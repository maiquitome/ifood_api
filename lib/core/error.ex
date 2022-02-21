defmodule Core.Error do
  @moduledoc """
  Error Struct.
  """

  @keys [:status, :result]

  @enforce_keys @keys

  defstruct @keys

  def build(status, result)
      when is_atom(status)
      when is_binary(result)
      when is_struct(result, Ecto.Changeset) do
    %__MODULE__{
      status: status,
      result: result
    }
  end
end
