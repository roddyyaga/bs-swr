module Raw = Raw

type 'data bound_mutate =
  ?data:'data -> ?shouldRevalidate:bool -> unit -> 'data option Js.Promise.t

type 'data responseInterface = {
  data: 'data option;
  error: Js.Promise.error;
  revalidate: unit -> bool Js.Promise.t;
  mutate: 'data bound_mutate;
  isValidating: bool;
}

let wrap_raw_response_intf = function[@warning "-45"]
  | Raw.{ data; error; revalidate; mutate; isValidating } ->
      let wrapped_mutate ?data ?shouldRevalidate () =
        mutate data shouldRevalidate
      in
      { data; error; revalidate; isValidating; mutate = wrapped_mutate }

let useSWR x f = Raw.useSWR1 [| x |] f |> wrap_raw_response_intf
