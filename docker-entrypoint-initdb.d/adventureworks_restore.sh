#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL

	CREATE TABLE dim_account(
		account_key int PRIMARY KEY NOT NULL,
		parent_account_key int NULL,
		account_code_alternate_key int NULL,
		parent_account_code_alternate_key int NULL,
		account_description varchar(50) NULL,
		account_type varchar(50) NULL,
		operator varchar(50) NULL,
		custom_members varchar(300) NULL,
		value_type varchar(50) NULL,
		custom_member_options varchar(200) NULL
	) ;

	CREATE TABLE dim_currency(
		currency_key int PRIMARY KEY NOT NULL,
		currency_alternate_key nchar(3) NOT NULL,
		currency_name varchar(50) NOT NULL
	) ;

	CREATE TABLE dim_customer(
		customer_key int PRIMARY KEY NOT NULL,
		geography_key int NULL,
		customer_alternate_key varchar(15) NOT NULL,
		title varchar(8) NULL,
		first_name varchar(50) NULL,
		middle_name varchar(50) NULL,
		last_name varchar(50) NULL,
		name_style bit NULL,
		birth_date date NULL,
		marital_status nchar(1) NULL,
		suffix varchar(10) NULL,
		gender varchar(1) NULL,
		email_address varchar(50) NULL,
		yearly_income money NULL,
		total_children int NULL,
		number_children_at_home int NULL,
		english_education varchar(40) NULL,
		spanish_education varchar(40) NULL,
		french_education varchar(40) NULL,
		english_occupation varchar(100) NULL,
		spanish_occupation varchar(100) NULL,
		french_occupation varchar(100) NULL,
		house_owner_flag nchar(1) NULL,
		number_cars_owned int NULL,
		address_line1 varchar(120) NULL,
		address_line2 varchar(120) NULL,
		phone varchar(20) NULL,
		date_first_purchase date NULL,
		commute_distance varchar(15) NULL
	) ;

	CREATE TABLE dim_date(
		date_key int NOT NULL,
		full_date_alternate_key date NOT NULL,
		day_number_of_week int NOT NULL,
		english_day_name_of_week varchar(10) NOT NULL,
		spanish_day_name_of_week varchar(10) NOT NULL,
		french_day_name_of_week varchar(10) NOT NULL,
		day_number_of_month int NOT NULL,
		day_number_of_year smallint NOT NULL,
		week_number_of_year int NOT NULL,
		english_month_name varchar(10) NOT NULL,
		spanish_month_name varchar(10) NOT NULL,
		french_month_name varchar(10) NOT NULL,
		month_number_of_year int NOT NULL,
		calendar_quarter int NOT NULL,
		calendar_year smallint NOT NULL,
		calendar_semester int NOT NULL,
		fiscal_quarter int NOT NULL,
		fiscal_year smallint NOT NULL,
		fiscal_semester int NOT NULL
	) ;

	CREATE TABLE dim_department_group(
		department_group_key int PRIMARY KEY NOT NULL,
		parent_department_group_key int NULL,
		department_group_name varchar(50) NULL
	) ;

	CREATE TABLE dim_employee(
		employee_key int PRIMARY KEY NOT NULL,
		parent_employee_key int NULL,
		employee_national_id_alternate_key varchar(15) NULL,
		parent_employee_national_id_alternate_key varchar(15) NULL,
		sales_territory_key int NULL,
		first_name varchar(50) NOT NULL,
		last_name varchar(50) NOT NULL,
		middle_name varchar(50) NULL,
		name_style bit NOT NULL,
		title varchar(50) NULL,
		hire_date date NULL,
		birth_date date NULL,
		login_id varchar(256) NULL,
		email_address varchar(50) NULL,
		phone varchar(25) NULL,
		marital_status nchar(1) NULL,
		emergency_contact_name varchar(50) NULL,
		emergency_contact_phone varchar(25) NULL,
		salaried_flag bit NULL,
		gender nchar(1) NULL,
		pay_frequency int NULL,
		base_rate money NULL,
		vacation_hours smallint NULL,
		sick_leave_hours smallint NULL,
		current_flag bit NOT NULL,
		sales_person_flag bit NOT NULL,
		department_name varchar(50) NULL,
		start_date date NULL,
		end_date date NULL,
		status varchar(50) NULL,
		employee_photo BYTEA NULL
	) ;

	CREATE TABLE dim_geography(
		geography_key int PRIMARY KEY NOT NULL,
		city varchar(30) NULL,
		state_province_code varchar(3) NULL,
		state_province_name varchar(50) NULL,
		country_region_code varchar(3) NULL,
		english_country_region_name varchar(50) NULL,
		SpanishCountryRegionName varchar(50) NULL,
		french_country_region_name varchar(50) NULL,
		postal_code varchar(15) NULL,
		sales_territory_key int NULL,
		ip_address_locator varchar(15) NULL
	) ;

	CREATE TABLE dim_organization(
		organization_key int PRIMARY KEY NOT NULL,
		parent_organization_key int NULL,
		percentage_of_ownership varchar(16) NULL,
		organization_name varchar(50) NULL,
		currency_key int NULL
	) ;

	CREATE TABLE dim_product(
		product_key int PRIMARY KEY NOT NULL,
		product_alternate_key varchar(25) NULL,
		product_subcategory_key int NULL,
		weight_unit_measure_code nchar(3) NULL,
		size_unit_measure_code nchar(3) NULL,
		english_product_name varchar(100) NOT NULL,
		spanish_product_name varchar(100) NULL,
		french_product_name varchar(100) NULL,
		standard_cost money NULL,
		finished_goods_flag bit NOT NULL,
		color varchar(15) NOT NULL,
		safety_stock_level smallint NULL,
		reorder_point smallint NULL,
		list_price money NULL,
		size varchar(50) NULL,
		size_range varchar(50) NULL,
		weight float NULL,
		days_to_manufacture int NULL,
		product_line nchar(2) NULL,
		dealer_price money NULL,
		class nchar(2) NULL,
		style nchar(2) NULL,
		model_name varchar(50) NULL,
		large_photo BYTEA NULL,
		english_description text NULL,
		french_description text NULL,
		chinese_description text NULL,
		arabic_description text NULL,
		hebrew_description text NULL,
		thai_description text NULL,
		german_description text NULL,
		japanese_description text NULL,
		turkish_description text NULL,
		start_date timestamp NULL,
		end_date timestamp NULL,
		status varchar(7) NULL
	) ;

	CREATE TABLE dim_product_category(
		product_category_key int PRIMARY KEY NOT NULL,
		product_category_alternate_key int NULL,
		english_product_category_name varchar(50) NOT NULL,
		spanish_product_category_name varchar(50) NOT NULL,
		french_product_category_name varchar(50) NOT NULL
	) ;

	CREATE TABLE dim_product_subcategory(
		product_subcategory_key int PRIMARY KEY NOT NULL,
		product_subcategory_alternate_key int NULL,
		english_product_subcategory_name varchar(50) NOT NULL,
		spanish_product_subcategory_name varchar(50) NOT NULL,
		french_product_subcategory_name varchar(50) NOT NULL,
		product_category_key int NULL
	) ;

	CREATE TABLE dim_promotion(
		promotion_key int PRIMARY KEY NOT NULL,
		promotion_alternate_key int NULL,
		english_promotion_name varchar(255) NULL,
		spanish_promotion_name varchar(255) NULL,
		french_promotion_name varchar(255) NULL,
		discount_pct float NULL,
		english_promotion_type varchar(50) NULL,
		spanish_promotion_type varchar(50) NULL,
		french_promotion_type varchar(50) NULL,
		english_promotion_category varchar(50) NULL,
		spanish_promotion_category varchar(50) NULL,
		french_promotion_category varchar(50) NULL,
		start_date timestamp NOT NULL,
		end_date timestamp NULL,
		min_qty int NULL,
		max_qty int NULL
	) ;

	CREATE TABLE dim_reseller(
		reseller_key int PRIMARY KEY NOT NULL,
		geography_key int NULL,
		reseller_alternate_key varchar(15) NULL,
		phone varchar(25) NULL,
		business_type varchar(20) NOT NULL,
		reseller_name varchar(50) NOT NULL,
		number_employees int NULL,
		order_frequency char(1) NULL,
		order_month int NULL,
		first_order_year int NULL,
		last_order_year int NULL,
		product_line varchar(50) NULL,
		address_line1 varchar(60) NULL,
		address_line2 varchar(60) NULL,
		annual_sales money NULL,
		bank_name varchar(50) NULL,
		min_payment_type int NULL,
		min_payment_amount money NULL,
		annual_revenue money NULL,
		year_opened int NULL
	) ;

	CREATE TABLE dim_sales_reason(
		sales_reason_key int PRIMARY KEY NOT NULL,
		sales_reason_alternate_key int NOT NULL,
		sales_reason_name varchar(50) NOT NULL,
		sales_reason_reason_type varchar(50) NOT NULL
	) ;

	CREATE TABLE dim_sales_territory(
		sales_territory_key int PRIMARY KEY NOT NULL,
		sales_territory_alternate_key int NULL,
		sales_territory_region varchar(50) NOT NULL,
		sales_territory_country varchar(50) NOT NULL,
		sales_territory_group varchar(50) NULL,
		sales_territory_image BYTEA NULL
	) ;

	CREATE TABLE dim_scenario(
		scenario_key int PRIMARY KEY NOT NULL,
		scenario_name varchar(50) NULL
	) ;

	CREATE TABLE fact_additional_international_product_description(
		product_key int NOT NULL,
		culture_name varchar(50) NOT NULL,
		product_description text NOT NULL
	) ;

	CREATE TABLE fact_call_center(
		fact_call_center_id int PRIMARY KEY NOT NULL,
		date_key int NOT NULL,
		wage_type varchar(15) NOT NULL,
		shift varchar(20) NOT NULL,
		level_one_operators smallint NOT NULL,
		level_two_operators smallint NOT NULL,
		total_operators smallint NOT NULL,
		calls int NOT NULL,
		automatic_responses int NOT NULL,
		orders int NOT NULL,
		issues_raised smallint NOT NULL,
		average_time_per_issue smallint NOT NULL,
		service_grade float NOT NULL,
		date timestamp NULL
	) ;

	CREATE TABLE fact_currency_rate(
		currency_key int NOT NULL,
		date_key int NOT NULL,
		average_rate float NOT NULL,
		end_of_day_rate float NOT NULL,
		date timestamp NULL
	) ;

	CREATE TABLE fact_finance(
		finance_key int PRIMARY KEY NOT NULL,
		date_key int NOT NULL,
		organization_key int NOT NULL,
		department_group_key int NOT NULL,
		scenario_key int NOT NULL,
		account_key int NOT NULL,
		amount float NOT NULL,
		date timestamp NULL
	) ;

	CREATE TABLE fact_internet_sales(
		product_key int NOT NULL,
		order_date_key int NOT NULL,
		due_date_key int NOT NULL,
		ship_date_key int NOT NULL,
		customer_key int NOT NULL,
		promotion_key int NOT NULL,
		currency_key int NOT NULL,
		sales_territory_key int NOT NULL,
		sales_order_number varchar(20) NOT NULL,
		sales_order_line_number int NOT NULL,
		revision_number int NOT NULL,
		order_quantity smallint NOT NULL,
		unit_price money NOT NULL,
		extended_amount money NOT NULL,
		unit_price_discount_pct float NOT NULL,
		discount_amount float NOT NULL,
		product_standard_cost money NOT NULL,
		total_product_cost money NOT NULL,
		sales_amount money NOT NULL,
		tax_amt money NOT NULL,
		freight money NOT NULL,
		carrier_tracking_number varchar(25) NULL,
		customer_po_number varchar(25) NULL,
		order_date timestamp NULL,
		due_date timestamp NULL,
		ship_date timestamp NULL
	) ;

	CREATE TABLE fact_internet_sales_reason(
		sales_order_number varchar(20) NOT NULL,
		sales_order_line_number int NOT NULL,
		sales_reason_key int NOT NULL
	) ;

	CREATE TABLE fact_product_inventory(
		product_key int NOT NULL,
		date_key int NOT NULL,
		movement_date date NOT NULL,
		unit_cost money NOT NULL,
		units_in int NOT NULL,
		units_out int NOT NULL,
		units_balance int NOT NULL
	) ;

	CREATE TABLE fact_reseller_sales(
		product_key int NOT NULL,
		order_date_key int NOT NULL,
		due_date_key int NOT NULL,
		ship_date_key int NOT NULL,
		reseller_key int NOT NULL,
		employee_key int NOT NULL,
		promotion_key int NOT NULL,
		currency_key int NOT NULL,
		sales_territory_key int NOT NULL,
		sales_order_number varchar(20) NOT NULL,
		sales_order_line_number int NOT NULL,
		revision_number int NULL,
		order_quantity smallint NULL,
		unit_price money NULL,
		extended_amount money NULL,
		unit_price_discount_pct float NULL,
		discount_amount float NULL,
		product_standard_cost money NULL,
		total_product_cost money NULL,
		sales_amount money NULL,
		tax_amt money NULL,
		freight money NULL,
		carrier_tracking_number varchar(25) NULL,
		customer_po_number varchar(25) NULL,
		order_date timestamp NULL,
		due_date timestamp NULL,
		ship_date timestamp NULL
	) ;

	CREATE TABLE fact_sales_quota(
		sales_quota_key int PRIMARY KEY NOT NULL,
		employee_key int NOT NULL,
		date_key int NOT NULL,
		calendar_year smallint NOT NULL,
		calendar_quarter int NOT NULL,
		sales_amount_quota money NOT NULL,
		date timestamp NULL
	) ;

	CREATE TABLE fact_survey_response(
		survey_response_key int PRIMARY KEY NOT NULL,
		date_key int NOT NULL,
		customer_key int NOT NULL,
		product_category_key int NOT NULL,
		english_product_category_name varchar(50) NOT NULL,
		product_subcategory_key int NOT NULL,
		english_product_subcategory_name varchar(50) NOT NULL,
		date timestamp NULL
	) ;

	CREATE TABLE new_fact_currency_rate(
		average_rate real NULL,
		currency_id varchar(3) NULL,
		currency_date date NULL,
		end_of_day_rate real NULL,
		currency_key int NULL,
		date_key int NULL
	) ;

	CREATE TABLE prospective_buyer(
		prospective_buyer_key int PRIMARY KEY NOT NULL,
		prospect_alternate_key varchar(15) NULL,
		first_name varchar(50) NULL,
		middle_name varchar(50) NULL,
		last_name varchar(50) NULL,
		birth_date timestamp NULL,
		marital_status nchar(1) NULL,
		gender varchar(1) NULL,
		email_address varchar(50) NULL,
		yearly_income money NULL,
		total_children int NULL,
		number_children_at_home int NULL,
		education varchar(40) NULL,
		occupation varchar(100) NULL,
		house_owner_flag nchar(1) NULL,
		number_cars_owned int NULL,
		address_line1 varchar(120) NULL,
		address_line2 varchar(120) NULL,
		city varchar(30) NULL,
		state_province_code varchar(3) NULL,
		postal_code varchar(15) NULL,
		phone varchar(20) NULL,
		salutation varchar(8) NULL,
		unknown int NULL
	) ;

	COPY dim_account from '/docker-entrypoint-initdb.d/dim_account.csv' DELIMITERS '|' CSV;
	COPY dim_currency from '/docker-entrypoint-initdb.d/dim_currency.csv' DELIMITERS '|' CSV;
	COPY dim_customer from '/docker-entrypoint-initdb.d/dim_customer.csv' DELIMITERS '|' CSV;
	COPY dim_date from '/docker-entrypoint-initdb.d/dim_date.csv' DELIMITERS '|' CSV;
	COPY dim_department_group from '/docker-entrypoint-initdb.d/dim_department_group.csv' DELIMITERS '|' CSV;
	COPY dim_employee from '/docker-entrypoint-initdb.d/dim_employee.csv' DELIMITERS '|' CSV;
	COPY dim_geography from '/docker-entrypoint-initdb.d/dim_geography.csv' DELIMITERS '|' CSV;
	COPY dim_organization from '/docker-entrypoint-initdb.d/dim_organization.csv' DELIMITERS '|' CSV;
	COPY dim_product from '/docker-entrypoint-initdb.d/dim_product.csv' DELIMITERS '|' CSV;
	COPY dim_product_category from '/docker-entrypoint-initdb.d/dim_product_category.csv' DELIMITERS '|' CSV;
	COPY dim_product_subcategory from '/docker-entrypoint-initdb.d/dim_product_subcategory.csv' DELIMITERS '|' CSV;
	COPY dim_promotion from '/docker-entrypoint-initdb.d/dim_promotion.csv' DELIMITERS '|' CSV;
	COPY dim_reseller from '/docker-entrypoint-initdb.d/dim_reseller.csv' DELIMITERS '|' CSV;
	COPY dim_sales_reason from '/docker-entrypoint-initdb.d/dim_sales_reason.csv' DELIMITERS '|' CSV;
	COPY dim_sales_territory from '/docker-entrypoint-initdb.d/dim_sales_territory.csv' DELIMITERS '|' CSV;
	COPY dim_scenario from '/docker-entrypoint-initdb.d/dim_scenario.csv' DELIMITERS '|' CSV;
	COPY fact_additional_international_product_description from '/docker-entrypoint-initdb.d/fact_additional_international_product_description.csv' DELIMITERS '|' CSV;
	COPY fact_call_center from '/docker-entrypoint-initdb.d/fact_call_center.csv' DELIMITERS '|' CSV;
	COPY fact_currency_rate from '/docker-entrypoint-initdb.d/fact_currency_rate.csv' DELIMITERS '|' CSV;
	COPY fact_finance from '/docker-entrypoint-initdb.d/fact_finance.csv' DELIMITERS '|' CSV;
	COPY fact_internet_sales from '/docker-entrypoint-initdb.d/fact_internet_sales.csv' DELIMITERS '|' CSV;
	COPY fact_internet_sales_reason from '/docker-entrypoint-initdb.d/fact_internet_sales_reason.csv' DELIMITERS '|' CSV;
	COPY fact_product_inventory from '/docker-entrypoint-initdb.d/fact_product_inventory.csv' DELIMITERS '|' CSV;
	COPY fact_reseller_sales from '/docker-entrypoint-initdb.d/fact_reseller_sales.csv' DELIMITERS '|' CSV;
	COPY fact_sales_quota from '/docker-entrypoint-initdb.d/fact_sales_quota.csv' DELIMITERS '|' CSV;
	COPY fact_survey_response from '/docker-entrypoint-initdb.d/fact_survey_response.csv' DELIMITERS '|' CSV;
	COPY new_fact_currency_rate from '/docker-entrypoint-initdb.d/new_fact_currency_rate.csv' DELIMITERS '|' CSV;
	COPY prospective_buyer from '/docker-entrypoint-initdb.d/prospective_buyer.csv' DELIMITERS '|' CSV;

EOSQL
