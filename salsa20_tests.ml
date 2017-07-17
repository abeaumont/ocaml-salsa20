let test_salsa20 ~hash ~key ~nonce ~input ~output =
  let open Nocrypto.Uncommon.Cs in
  let open Cstruct in
  let open Alcotest in
  let key = of_hex key
  and nonce = of_hex nonce
  and input = of_hex input
  and output = output |> of_hex |> to_string in
  (fun () ->
    let output2 =
      Salsa20.create ~hash key nonce
      |> Salsa20.encrypt input
      |> to_string in
    check int "Salsa20 test" (String.length output) (String.length output2))

let salsa20_8_tests = [
]

let salsa20_12_tests = [
]

let test_salsa20_20 ~key ~nonce ~input ~output =
  test_salsa20 ~hash:Salsa20_core.salsa20_20_core ~key ~nonce ~input ~output

let salsa20_20_128bit_ecrypt_set1_vector0_test =
  test_salsa20_20
    ~key:"80000000000000000000000000000000"
    ~nonce:"0000000000000000"
    ~input:(String.make 128 '0')
    ~output:("4DFA5E481DA23EA09A31022050859936" ^
             "DA52FCEE218005164F267CB65F5CFD7F" ^
             "2B4F97E0FF16924A52DF269515110A07" ^
             "F9E460BC65EF95DA58F740B7D1DBB0AA")

let salsa20_20_tests = [
  "Set 1, vector# 0", `Quick, salsa20_20_128bit_ecrypt_set1_vector0_test;
]

let () =
  Alcotest.run "Salsa20 Tests" [
    "Salsa20 8 tests", salsa20_8_tests;
    "Salsa20 12 tests", salsa20_12_tests;
    "Salsa20 20 tests", salsa20_20_tests;
  ]
