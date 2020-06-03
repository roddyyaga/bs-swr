type 'data bound_mutate =
  'data option -> bool option -> 'data option Js.Promise.t

type 'data responseInterface = {
  data: 'data option;
  error: Js.Promise.error;
  revalidate: unit -> bool Js.Promise.t;
  mutate: 'data bound_mutate;
  isValidating: bool;
}

type revalidateOptionInterface = { retryCount: int; dedupe: bool }

type revalidateType = revalidateOptionInterface -> bool Js.Promise.t

type ('key, 'data) configInterface = {
  (* Global options *)
  errorRetryInterval: int option;
  errorRetryCount: int option;
  loadingTimeout: int option;
  focusThrottleInterval: int option;
  dedupingInterval: int option;
  refreshInterval: int option;
  refreshWhenHidden: bool option;
  refreshWhenOffline: bool option;
  revalidateOnFocus: bool option;
  revalidateOnReconnect: bool option;
  shouldRetryOnError: bool option;
  suspense: bool option;
  initialData: 'data option;
  onLoadingSlow: ('key -> ('key, 'data) configInterface -> unit) option;
  onSuccess: ('data -> 'key -> ('key, 'data) configInterface -> unit) option;
  onError: (Js.Promise.error -> 'key -> ('key, 'data) configInterface) option;
  onErrorRetry:
    (Js.Promise.error -> 'key -> ('key, 'data) configInterface) option;
  compare: ('data option -> 'data option -> bool) option;
}

external useSWR_string :
  string -> (string -> 'data Js.Promise.t) -> 'data responseInterface
  = "default"
  [@@bs.val] [@@bs.module "swr"]

external useSWR_string_config :
  string ->
  (string -> 'data Js.Promise.t) ->
  (string, 'data) configInterface ->
  'data responseInterface = "default"
  [@@bs.val] [@@bs.module "swr"]

(* array must be of length 1 *)
external useSWR1 :
  'param array -> ('param -> 'data Js.Promise.t) -> 'data responseInterface
  = "default"
  [@@bs.val] [@@bs.module "swr"]

(* array must be of length 1 *)
external useSWR1_config :
  'param array ->
  ('param -> 'data Js.Promise.t) ->
  ('param array, 'data) configInterface ->
  'data responseInterface = "default"
  [@@bs.val] [@@bs.module "swr"]

external useSWR2 :
  'a * 'b -> ('a -> 'b -> 'data Js.Promise.t) -> 'data responseInterface
  = "default"
  [@@bs.val] [@@bs.module "swr"]

external useSWR2_config :
  'a * 'b ->
  ('a -> 'b -> 'data Js.Promise.t) ->
  ('a * 'b, 'data) configInterface ->
  'data responseInterface = "default"
  [@@bs.val] [@@bs.module "swr"]
