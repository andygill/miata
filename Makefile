CAR=MXR  # with roof
#CAR=MX5  # soft top
all::
	echo > TMP
	make dealers CAR=MXR
#	make dealers CAR=MX5
	make render

dealers::
	@make dealer DEALER=70623   LOCATION="Lawrence"
	@make dealer DEALER=34567   LOCATION="Topeka"
	@make dealer DEALER=34635   LOCATION="Kansas City, Kansas"
	@make dealer DEALER=34487   LOCATION="Kansas City Airport"
	@make dealer DEALER=34690   LOCATION="Kansas City, MO"
	@make dealer DEALER=70624   LOCATION="Witchita"
	@make dealer DEALER=34566   LOCATION="Lincon"
	@make dealer DEALER=61620   LOCATION="Columbia"
	@make dealer DEALER=70933   LOCATION="Rolla"
	@make dealer DEALER=34482   LOCATION="BentonVille, R"
	@make dealer DEALER=34556   LOCATION="Springfield"
	@make dealer DEALER=34245   LOCATION="Tulsa, OK"
	@make dealer DEALER=61640   LOCATION="Urbandale, IA"
	@make dealer DEALER=34710   LOCATION="OMAHA, NE"
	@make dealer DEALER=34616   LOCATION="BELLEVUE, NE"
	@make dealer DEALER=34589   LOCATION="OKLAHOMA CITY, OK"
	@make dealer DEALER=34700   LOCATION="NORMAN, OK"
	@make dealer DEALER=34706   LOCATION="LAWTON, OK"
	@make dealer DEALER=34703   LOCATION="AURORA, CO"
	@make dealer DEALER=42140   LOCATION="CENTENNIAL, CO"
	@make dealer DEALER=41320   LOCATION="LITTLETON, CO"
	@make dealer DEALER=34699   LOCATION="LAKEWOOD, CO"
	@make dealer DEALER=42025   LOCATION="BROOMFIELD, CO"
	@make dealer DEALER=42132   LOCATION="LONGMONT, CO"
	@make dealer DEALER=70927   LOCATION="ELLISVILLE, MO"
	@make dealer DEALER=70925   LOCATION="ST. LOUIS, MO"
	@make dealer DEALER=34581   LOCATION="ST. LOUIS, MO"
	@make dealer DEALER=34469   LOCATION="SAINT PETERS, MO"
	@make dealer DEALER=61554   LOCATION="SPRINGFIELD, IL"
	@make dealer DEALER=61566   LOCATION="SIOUX CITY, IA"
	@make dealer DEALER=34541   LOCATION="DODGE CITY, KS"
	@make dealer DEALER=70151   LOCATION="OFALLON, IL"

dealer::
	@curl -X POST -s \
		https://www.mazdausa.com/api/inventorysearch \
		-H 'Content-Type: application/x-www-form-urlencoded; charset=UTF-8' \
		-d 'ResultsPageSize=12&ResultsParameterFilter=&ResultsSortAttribute=Year&ResultsSortOrder=asc&ResultsStart=1&NearResultsStart=1&TimeSearchPerformed=&Vehicle%5BDealerId%5D%5B%5D=$(DEALER)&Vehicle%5Bcond%5D%5B%5D=c&Vehicle%5BType%5D%5B%5D=c&Vehicle%5BCarline%5D%5B%5D=$(CAR)&Vehicle%5BType%5D%5B%5D=n&Vehicle%5BisDigitalRetail%5D%5B%5D=false&Vehicle%5BsortTitle%5D%5B%5D=Distance%3A+Near+to+Far&GetNearMatch=false&resultsSortParameter%5B0%5D%5BresultsSortAttribute%5D=DEALERID&resultsSortParameter%5B0%5D%5BresultsSortOrder%5D=asc&resultsSortParameter%5B1%5D%5BresultsSortAttribute%5D=price&resultsSortParameter%5B1%5D%5BresultsSortOrder%5D=asc&resultsSortParameter%5B2%5D%5BresultsSortAttribute%5D=Year&resultsSortParameter%5B2%5D%5BresultsSortOrder%5D=desc&resultsSortParameter%5B3%5D%5BresultsSortAttribute%5D=Mileage&resultsSortParameter%5B3%5D%5BresultsSortOrder%5D=asc&sortVal=DEALERID%7Casc%2Cprice%7Casc%2CYear%7Cdesc%2CMileage%7Casc&sortTitle=Distance%3A+Near+to+Far' \
		| jq '.response.Vehicles|map(select(.Model.Transmission.Desc | contains("Automatic")))|[.[]|{Price, Color:.Colors.MajorExteriorColor, DealerId, DealerName, Mileage, Model:.Model.Name, Trans:.Model.Transmission.Desc, TrimName:.Model.TrimName, Year:.Model.Year, Vin, Availability, Status, Location: "$(LOCATION)"}]'  >> TMP


render::
	jq flatten -s TMP > cars.json
	jq --color-output flatten -s TMP






