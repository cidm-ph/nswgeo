test_that("LHD names have optional LHD suffix", {
  expect_equal(
    cartographer::resolve_feature_names("Sydney", "nswgeo.lhd"),
    cartographer::resolve_feature_names(
      "Sydney Local Health District",
      "nswgeo.lhd"
    )
  )
  expect_equal(
    cartographer::resolve_feature_names("Sydney LHD", "nswgeo.lhd"),
    cartographer::resolve_feature_names(
      "Sydney Local Health District",
      "nswgeo.lhd"
    )
  )
})
