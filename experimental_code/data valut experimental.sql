DROP TABLE IF EXISTS sat_commodity_code_details;
DROP TABLE IF EXISTS sat_epu_details;
DROP TABLE IF EXISTS sat_declaration_line_consignor;
DROP TABLE IF EXISTS sat_declaration_line_consignee;
DROP TABLE IF EXISTS sat_declaration_line_countries;
DROP TABLE IF EXISTS sat_declaration_line_misc;
DROP TABLE IF EXISTS sat_declaration_declarant;
DROP TABLE IF EXISTS sat_declaration_cpc;
DROP TABLE IF EXISTS sat_declaration_static_dates;
DROP TABLE IF EXISTS sat_declaration_line_clearance_date;
DROP TABLE IF EXISTS sat_declaration_misc;
DROP TABLE IF EXISTS sat_goods_location_details;
DROP TABLE IF EXISTS sat_declaration_line_values;
DROP TABLE IF EXISTS sat_customs_route_details;
DROP TABLE IF EXISTS link_declaration_declaration_line;
DROP TABLE IF EXISTS link_declaration_epu;
DROP TABLE IF EXISTS link_declaration_line_goods_location;
DROP TABLE IF EXISTS link_declaration_line_customs_route;
DROP TABLE IF EXISTS link_declaration_line_commodity_code;
DROP TABLE IF EXISTS hub_declaration;
DROP TABLE IF EXISTS hub_declaration_line;
DROP TABLE IF EXISTS hub_goods_location;
DROP TABLE IF EXISTS hub_epu;
DROP TABLE IF EXISTS hub_customs_route;
DROP TABLE IF EXISTS hub_commodity_code;

CREATE TABLE hub_commodity_code (
  hash_key       VARCHAR PRIMARY KEY,
  load_date      TIMESTAMP,
  record_source  VARCHAR,
  commodity_code VARCHAR
);

CREATE TABLE sat_commodity_code_details (
  commodity_code_hash_key VARCHAR PRIMARY KEY REFERENCES hub_commodity_code (hash_key),
  load_date               TIMESTAMP,
  record_source           VARCHAR,
  hash_diff               VARCHAR,
  description             VARCHAR
);

CREATE TABLE hub_declaration (
  hash_key      VARCHAR PRIMARY KEY,
  load_date     TIMESTAMP,
  record_source VARCHAR,
  entry_no      VARCHAR
);

CREATE TABLE sat_declaration_declarant (
  declaration_hash_key VARCHAR PRIMARY KEY REFERENCES hub_declaration (hash_key),
  load_date            TIMESTAMP,
  record_source        VARCHAR,
  hash_diff            VARCHAR,
  trader_id            VARCHAR,
  name                 VARCHAR,
  street               VARCHAR,
  city                 VARCHAR,
  postcode             VARCHAR,
  country              VARCHAR,
  declarant_type       VARCHAR
);

CREATE TABLE sat_declaration_static_dates (
  declaration_hash_key VARCHAR PRIMARY KEY REFERENCES hub_declaration (hash_key),
  load_date            TIMESTAMP,
  record_source        VARCHAR,
  hash_diff            VARCHAR,
  entry_date           TIMESTAMP,
  acceptance_date      TIMESTAMP,
  import_date          TIMESTAMP
);

CREATE TABLE sat_declaration_cpc (
  declaration_hash_key VARCHAR PRIMARY KEY REFERENCES hub_declaration (hash_key),
  load_date            TIMESTAMP,
  record_source        VARCHAR,
  hash_diff            VARCHAR,
  cpc_code             VARCHAR
);

CREATE TABLE sat_declaration_misc (
  declaration_hash_key                                         VARCHAR PRIMARY KEY REFERENCES hub_declaration (hash_key),
  load_date                                                    TIMESTAMP,
  record_source                                                VARCHAR,
  hash_diff                                                    VARCHAR,
  entry_version_no                                             VARCHAR,
  entry_type                                                   VARCHAR,
  ics_code                                                     VARCHAR,
  mrn                                                          VARCHAR,
  master_ucr                                                   VARCHAR,
  declaration_ucr                                              VARCHAR,
  fir_dan                                                      VARCHAR,
  fir_dan_prefix                                               VARCHAR,
  representative_status_code                                   VARCHAR,
  nationality_of_active_means_of_transport_crossing_the_border VARCHAR
);

CREATE TABLE hub_declaration_line (
  hash_key      VARCHAR PRIMARY KEY,
  load_date     TIMESTAMP,
  record_source VARCHAR,
  entry_no      VARCHAR,
  item_no       VARCHAR
);

CREATE TABLE sat_declaration_line_clearance_date (
  declaration_line_hash_key VARCHAR PRIMARY KEY REFERENCES hub_declaration_line (hash_key),
  load_date                 TIMESTAMP,
  record_source             VARCHAR,
  hash_diff                 VARCHAR,
  clearance_date            TIMESTAMP
);

CREATE TABLE sat_declaration_line_consignor (
  declaration_line_hash_key VARCHAR PRIMARY KEY REFERENCES hub_declaration_line (hash_key),
  load_date                 TIMESTAMP,
  record_source             VARCHAR,
  hash_diff                 VARCHAR,
  trader_id                 VARCHAR,
  name                      VARCHAR,
  street                    VARCHAR,
  city                      VARCHAR,
  postcode                  VARCHAR,
  country                   VARCHAR
);

CREATE TABLE sat_declaration_line_consignee (
  declaration_line_hash_key VARCHAR PRIMARY KEY REFERENCES hub_declaration_line (hash_key),
  load_date                 TIMESTAMP,
  record_source             VARCHAR,
  hash_diff                 VARCHAR,
  trader_id                 VARCHAR,
  name                      VARCHAR,
  street                    VARCHAR,
  city                      VARCHAR,
  postcode                  VARCHAR,
  country                   VARCHAR
);

CREATE TABLE sat_declaration_line_values (
  declaration_line_hash_key VARCHAR PRIMARY KEY REFERENCES hub_declaration_line (hash_key),
  load_date                 TIMESTAMP,
  record_source             VARCHAR,
  hash_diff                 VARCHAR,
  item_Price                DECIMAL(12, 2),
  item_customs_value        DECIMAL(12, 2),
  item_customs_duty_paid    DECIMAL(12, 2),
  item_vat_value            DECIMAL(12, 2)
);

CREATE TABLE sat_declaration_line_countries (
  declaration_line_hash_key VARCHAR PRIMARY KEY REFERENCES hub_declaration_line (hash_key),
  load_date                 TIMESTAMP,
  record_source             VARCHAR,
  hash_diff                 VARCHAR,
  dispatch_country          VARCHAR,
  destination_country       VARCHAR
);

CREATE TABLE sat_declaration_line_misc (
  declaration_line_hash_key       VARCHAR PRIMARY KEY REFERENCES hub_declaration_line (hash_key),
  load_date                       TIMESTAMP,
  record_source                   VARCHAR,
  hash_diff                       VARCHAR,
  import_date                     TIMESTAMP,
  item_no                         VARCHAR,
  premises_id                     VARCHAR,
  customs_check                   VARCHAR,
  tax_point_date                  TIMESTAMP,
  goods_departure_date            TIMESTAMP,
  permission_to_progress_date     TIMESTAMP,
  description_of_goods            VARCHAR,
  type_of_packages_code           VARCHAR,
  number_of_packages              VARCHAR,
  additional_procedure            VARCHAR,
  requested_procedure             VARCHAR,
  previous_procedure              VARCHAR,
  shipping_marks                  VARCHAR,
  document_type                   VARCHAR,
  previous_document               VARCHAR,
  previous_document_reference     VARCHAR,
  inland_mode_of_transport        VARCHAR,
  country_of_dispatch_export_code VARCHAR
);

CREATE TABLE hub_customs_route (
  hash_key           VARCHAR PRIMARY KEY,
  load_date          TIMESTAMP,
  record_source      VARCHAR,
  customs_route_code VARCHAR
);

CREATE TABLE sat_customs_route_details (
  goods_location_hash_key   VARCHAR PRIMARY KEY REFERENCES hub_customs_route (hash_key),
  load_date                 TIMESTAMP,
  record_source             VARCHAR,
  customs_route_description VARCHAR
);

CREATE TABLE hub_goods_location (
  hash_key      VARCHAR PRIMARY KEY,
  load_date     TIMESTAMP,
  record_source VARCHAR,
  location_code VARCHAR
);

CREATE TABLE sat_goods_location_details (
  goods_location_hash_key VARCHAR PRIMARY KEY REFERENCES hub_goods_location (hash_key),
  load_date               TIMESTAMP,
  record_source           VARCHAR,
  description             VARCHAR
);

CREATE TABLE hub_epu (
  hash_key      VARCHAR PRIMARY KEY,
  load_date     TIMESTAMP,
  record_source VARCHAR,
  epu_no        VARCHAR
);

CREATE TABLE sat_epu_details (
  epu_hash_key  VARCHAR PRIMARY KEY REFERENCES hub_epu (hash_key),
  load_date     TIMESTAMP,
  record_source VARCHAR,
  description   VARCHAR
);

CREATE TABLE link_declaration_declaration_line (
  hash_key                  VARCHAR,
  load_date                 TIMESTAMP,
  record_source             VARCHAR,
  declaration_hash_key      VARCHAR REFERENCES hub_declaration (hash_key),
  declaration_line_hash_key VARCHAR REFERENCES hub_declaration_line (hash_key)
);

CREATE TABLE link_declaration_line_goods_location (
  hash_key                  VARCHAR,
  load_date                 TIMESTAMP,
  record_source             VARCHAR,
  declaration_line_hash_key VARCHAR REFERENCES hub_declaration_line (hash_key),
  goods_location_hash_key   VARCHAR REFERENCES hub_goods_location (hash_key)
);

CREATE TABLE link_declaration_epu (
  hash_key             VARCHAR PRIMARY KEY,
  load_date            TIMESTAMP,
  record_source        VARCHAR,
  declaration_hash_key VARCHAR REFERENCES hub_declaration (hash_key),
  epu_hash_key         VARCHAR REFERENCES hub_epu (hash_key)
);

CREATE TABLE link_declaration_line_customs_route (
  hash_key                  VARCHAR PRIMARY KEY,
  load_date                 TIMESTAMP,
  record_source             VARCHAR,
  declaration_line_hash_key VARCHAR REFERENCES hub_declaration_line (hash_key),
  customs_route_hash_key    VARCHAR REFERENCES hub_customs_route (hash_key)
);

CREATE TABLE link_declaration_line_commodity_code (
  hash_key                  VARCHAR PRIMARY KEY,
  load_date                 TIMESTAMP,
  record_source             VARCHAR,
  declaration_line_hash_key VARCHAR REFERENCES hub_declaration_line (hash_key),
  commodity_code_hash_key   VARCHAR REFERENCES hub_commodity_code (hash_key)
);

