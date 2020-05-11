type 'data bound_mutate =
  'data option -> bool option -> 'data option Js.Promise.t

type 'data responseInterface = {
  data: 'data option;
  error: Js.Promise.error;
  revalidate: unit -> bool Js.Promise.t;
  mutate: 'data bound_mutate;
  isValidating: bool;
}

external useSWR_string :
  string -> (string -> 'data Js.Promise.t) -> 'data responseInterface
  = "default"
  [@@bs.val] [@@bs.module "swr"]

(* array must be of length 1 *)
external useSWR1 :
  'param array -> ('param -> 'data Js.Promise.t) -> 'data responseInterface
  = "default"
  [@@bs.val] [@@bs.module "swr"]

external useSWR2 :
  'a * 'b -> ('a -> 'b -> 'data Js.Promise.t) -> 'data responseInterface
  = "default"
  [@@bs.val] [@@bs.module "swr"]
