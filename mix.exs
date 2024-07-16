defmodule HmacStorage.MixProject do
  use Mix.Project

  @version "0.1.0"
  @source_url "https://github.com/feng19/hmac_storage"

  def project do
    [
      app: :hmac_storage,
      version: @version,
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs(),
      package: package()
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      {:wechat, "~> 0.15", hex: :wechat_sdk},
      {:tesla_hmac_auth, "~> 0.1"},
      {:ex_doc, ">= 0.0.0", only: [:docs, :dev], runtime: false}
    ]
  end

  defp docs do
    [
      extras: [
        "README.md": [title: "Overview"]
      ],
      main: "HmacStorage",
      source_url: @source_url,
      source_ref: "master",
      formatters: ["html"],
      formatter_opts: [gfm: true]
    ]
  end

  defp package do
    [
      name: "hmac_storage",
      description: "Hub Http Client(HMac Auth) for WeChat Storage.",
      files: ["lib", "mix.exs", "README.md"],
      maintainers: ["feng19"],
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => @source_url}
    ]
  end
end
