(** {{:http://cr.yp.to/snuffle/spec.pdf} The Salsa20 specification}
    specifies a Salsa20/20 encryption function as well as a set of
    reduced Salsa20/8 and Salsa20/12 encryption functions.

    Note that only the 32-byte and 16-byte expansion function are
    implemented since. The 10-byte expansion functions is not
    supported, since it's not recommended. If you're interested in this
    reduced key length, it can still be easily generated. *)

type t
val create: ?hash:(Cstruct.t -> Cstruct.t) -> Cstruct.t -> Cstruct.t -> t
val encrypt: Cstruct.t -> t -> Cstruct.t
val decrypt: Cstruct.t -> t -> Cstruct.t
