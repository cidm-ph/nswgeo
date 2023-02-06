library(readr)
library(dplyr)

if (!file.exists("data-raw/australian_postcodes.csv")) {
  message("Downloading the source dataset from the ABS website...")
  postcodes_url <- "https://www.matthewproctor.com/Content/postcodes/australian_postcodes.csv"
  download.file(postcodes_url, destfile = "data-raw/australian_postcodes.csv")
  stopifnot(file.exists("data-raw/australian_postcodes.csv"))
}

postcodes <- read_csv("data-raw/australian_postcodes.csv", col_types = cols(
  id = col_double(),
  postcode = col_character(),
  locality = col_character(),
  state = col_character(),
  long = col_double(),
  lat = col_double(),
  dc = col_character(),
  type = col_character(),
  status = col_character(),
  sa3 = col_double(),
  sa3name = col_character(),
  sa4 = col_double(),
  sa4name = col_character(),
  region = col_character(),
  Lat_precise = col_double(),
  Long_precise = col_double(),
  SA1_MAINCODE_2011 = col_double(),
  SA1_MAINCODE_2016 = col_double(),
  SA2_MAINCODE_2016 = col_double(),
  SA2_NAME_2016 = col_character(),
  SA3_CODE_2016 = col_double(),
  SA3_NAME_2016 = col_character(),
  SA4_CODE_2016 = col_double(),
  SA4_NAME_2016 = col_character(),
  RA_2011 = col_double(),
  RA_2016 = col_double(),
  MMM_2015 = col_double(),
  MMM_2019 = col_double(),
  ced = col_character(),
  altitude = col_double(),
  chargezone = col_character(),
  phn_code = col_character(),
  phn_name = col_character(),
  lgaregion = col_character(),
  lgacode = col_double(),
  electorate = col_character(),
  electoraterating = col_character()
)) %>%
  select(postcode, locality, state, type, SA2_NAME_2016) %>%
  filter(state == "NSW") %>%
  mutate(special = (startsWith(postcode, "1")) | (type %in% c("LVR", "Post Office Boxes"))) %>%
  select(-type)

# manually confirmed on Australia Post website to remove ambiguities
manual <- read_csv("data-raw/postcodes_manual.csv", col_types = "cccc")
manual$manual_special <- manual$manual_special == "1"
manual$manual_old <- manual$manual_old == "1"
manual <- rename(manual, old = manual_old)
postcodes <-
  left_join(postcodes, manual, by = c("postcode", "locality")) %>%
  mutate(special = special | manual_special) %>%
  select(-manual_special)

# canonicalise any special postcodes
# note: locality is not unique, so diambiguate by using the SA2 name
postcodes <-
  postcodes %>%
  group_by(SA2_NAME_2016, locality) %>%
  mutate(
    canonical = {
      # any good postcodes are candidates for the canonical choice
      canon <- postcode[(is.na(special) | !special) & (is.na(old) | !old)]
      canon <- sort(unique(na.omit(c(canon, manual_canonical))))

      if (any(special, na.rm = TRUE) && length(canon) == 0) {
        # warning("No canonical postcodes")
        canon <- postcode
      }

      # duplicates need manual help to resolve
      if (length(canon) > 1) {
        canon <- paste0(canon, collapse = "|")
        warning(sprintf("Multiple postcodes: %s", canon))
      }

      canon
    }
  ) %>%
  ungroup() %>%
  select(-manual_canonical)

# postcodes <-
#   postcodes %>%
#   left_join(
#     data.frame(postcode = nswgeo::poa_nsw$POA_CODE_2021, has_geometry = TRUE),
#     by = c("canonical" = "postcode"))
# postcodes$has_geometry[is.na(postcodes$has_geometry)] <- FALSE

usethis::use_data(postcodes, overwrite = TRUE)
