#CAR=MXR  # with roof
CAR=MX5  # soft top
all::
	echo > TMP
	make dealers CAR=MXR
#	make dealers CAR=MX5
	make render

dealers::
	@make dealer DEALER=70623 CAR=$(CAR)  LOCATION="Lawrence"
	@make dealer DEALER=34567 CAR=$(CAR)  LOCATION="Topeka"
	@make dealer DEALER=34635 CAR=$(CAR)  LOCATION="Kansas City, Kansas"
	@make dealer DEALER=34487 CAR=$(CAR)  LOCATION="Kansas City Airport"
	@make dealer DEALER=34690 CAR=$(CAR)  LOCATION="Kansas City, MO"
	@make dealer DEALER=70624 CAR=$(CAR)  LOCATION="Witchita"
	@make dealer DEALER=34566 CAR=$(CAR)  LOCATION="Lincon"
	@make dealer DEALER=61620 CAR=$(CAR)  LOCATION="Columbia"
	@make dealer DEALER=70933 CAR=$(CAR)  LOCATION="Rolla"
	@make dealer DEALER=34482 CAR=$(CAR)  LOCATION="BentonVille, R"
	@make dealer DEALER=34556 CAR=$(CAR)  LOCATION="Springfield"
	@make dealer DEALER=34245 CAR=$(CAR)  LOCATION="Tulsa, OK"
	@make dealer DEALER=61640 CAR=$(CAR)  LOCATION="Urbandale, IA"
	@make dealer DEALER=34710 CAR=$(CAR)  LOCATION="OMAHA, NE"
	@make dealer DEALER=34616 CAR=$(CAR)  LOCATION="BELLEVUE, NE"
	@make dealer DEALER=34589 CAR=$(CAR)  LOCATION="OKLAHOMA CITY, OK"
	@make dealer DEALER=34700 CAR=$(CAR)  LOCATION="NORMAN, OK"
	@make dealer DEALER=34706 CAR=$(CAR)  LOCATION="LAWTON, OK"
	@make dealer DEALER=34703 CAR=$(CAR)  LOCATION="AURORA, CO"
	@make dealer DEALER=42140 CAR=$(CAR)  LOCATION="CENTENNIAL, CO"
	@make dealer DEALER=41320 CAR=$(CAR)  LOCATION="LITTLETON, CO"
	@make dealer DEALER=34699 CAR=$(CAR)  LOCATION="LAKEWOOD, CO"
	@make dealer DEALER=42025 CAR=$(CAR)  LOCATION="BROOMFIELD, CO"
	@make dealer DEALER=42132 CAR=$(CAR)  LOCATION="LONGMONT, CO"

dealer::
	@curl -X POST -s \
		https://www.mazdausa.com/api/inventorysearch \
		-H 'Content-Type: application/x-www-form-urlencoded; charset=UTF-8' \
		-d 'ResultsPageSize=12&ResultsParameterFilter=&ResultsSortAttribute=Year&ResultsSortOrder=asc&ResultsStart=1&NearResultsStart=1&TimeSearchPerformed=&Vehicle%5BDealerId%5D%5B%5D=$(DEALER)&Vehicle%5Bcond%5D%5B%5D=c&Vehicle%5BType%5D%5B%5D=c&Vehicle%5BCarline%5D%5B%5D=$(CAR)&Vehicle%5BType%5D%5B%5D=n&Vehicle%5BisDigitalRetail%5D%5B%5D=false&Vehicle%5BsortTitle%5D%5B%5D=Distance%3A+Near+to+Far&GetNearMatch=false&resultsSortParameter%5B0%5D%5BresultsSortAttribute%5D=DEALERID&resultsSortParameter%5B0%5D%5BresultsSortOrder%5D=asc&resultsSortParameter%5B1%5D%5BresultsSortAttribute%5D=price&resultsSortParameter%5B1%5D%5BresultsSortOrder%5D=asc&resultsSortParameter%5B2%5D%5BresultsSortAttribute%5D=Year&resultsSortParameter%5B2%5D%5BresultsSortOrder%5D=desc&resultsSortParameter%5B3%5D%5BresultsSortAttribute%5D=Mileage&resultsSortParameter%5B3%5D%5BresultsSortOrder%5D=asc&sortVal=DEALERID%7Casc%2Cprice%7Casc%2CYear%7Cdesc%2CMileage%7Casc&sortTitle=Distance%3A+Near+to+Far' \
		| jq '.response.Vehicles|map(select(.Model.Transmission.Desc | contains("Automatic")))|[.[]|{Price, Color:.Colors.MajorExteriorColor, DealerId, DealerName, Mileage, Model:.Model.Name, Trans:.Model.Transmission.Desc, TrimName:.Model.TrimName, Year:.Model.Year, Vin, Availability, Status, Location: "$(LOCATION)"}]'  >> TMP


render::
	jq flatten -s TMP > cars.json
	jq --color-output flatten -s TMP






