module Cs = Cstruct

type t = { mutable buffer: Cs.t; hash: Cs.t -> Cs.t }

let expand key nonce =
  if Cs.len nonce <> 8 then invalid_arg "nonce must be 8 byte long"
  else
    let (s, k0, k1) = match Cs.len key with
        32 -> let (k0, k1) = Cs.split key 16 in ("expand 32-byte k", k0, k1)
      | 16 -> ("expand 16-byte k", key, key)
      | _ -> invalid_arg "key must be either 32 (recommended) or 16 byte long)" in
    let state = Cs.create 64 in
    Cs.blit_from_string s 0 state 0 4;
    Cs.blit k0 0 state 4 16;
    Cs.blit_from_string s 4 state 20 4;
    Cs.blit nonce 0 state 24 8;
    for i = 0 to 3 do
      Cs.set_uint8 state (32 + i) 0;
    done;
    Cs.blit_from_string s 8 state 40 4;
    Cs.blit k1 0 state 44 16;
    Cs.blit_from_string s 12 state 60 4;
    state

let create ?(hash=Salsa20_core.salsa20_20_core) key nonce =
  let buffer = expand key nonce |> hash in {buffer; hash}

let encrypt input state =
  let l = Cs.len input in
  let output = Cs.create l in
  let i = ref 0 in
  while !i < l do
    let count = min 64 (l - !i) in
    let buffer = Cs.create count in
    Cs.blit input !i buffer 0 count;
    Nocrypto.Uncommon.Cs.xor_into state.buffer buffer count;
    Cs.blit buffer 0 output !i count;
    state.buffer <- state.hash state.buffer;
    i := !i + count;
  done;
  output

let decrypt input state =
  encrypt input state
