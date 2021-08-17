CAR=MXR  # with roof
#CAR=MX5  # soft top
ZIP=66047
all::
	make clean
	make dealers CAR=MXR
#	make dealers CAR=MX5
	make render
	git diff

clean::
	rm -f TMP
	rm -Rf *-cars.json

dealers::
	make dealer DEALER=70623   LOCATION="Lawrence"			DIST=0	ZIP=66047
	make dealer DEALER=34567   LOCATION="Topeka"			DIST=1	ZIP=66611
	make dealer DEALER=34635   LOCATION="Kansas City, Kansas"	DIST=40	ZIP=66061
	make dealer DEALER=34690   LOCATION="Kansas City, MO"		DIST=45	ZIP=64145
	make dealer DEALER=34693   LOCATION="LEES SUMMIT, MO"		DIST=55	ZIP=64081
	make dealer DEALER=34487   LOCATION="Kansas City Airport"	DIST=55	ZIP=64118
	make dealer DEALER=70624   LOCATION="Witchita"			DIST=	ZIP=67207
	make dealer DEALER=61620   LOCATION="Columbia"			DIST=	ZIP=65202
	make dealer DEALER=34616   LOCATION="BELLEVUE, NE"		DIST=	ZIP=68005

	make dealer DEALER=34710   LOCATION="OMAHA, NE"		DIST=	ZIP=68138
	make dealer DEALER=34566   LOCATION="Lincoln"			DIST=	ZIP=68521
	make dealer DEALER=34556   LOCATION="Springfield, MO"		DIST=	ZIP=65802
	make dealer DEALER=71012   LOCATION="Freemont, NE"		DIST=   ZIP=68025
	make dealer DEALER=34245   LOCATION="Tulsa, OK"		DIST=  	ZIP=75133
	make dealer DEALER=70933   LOCATION="Rolla, MO"		DIST=	ZIP=65584
	make dealer DEALER=61640   LOCATION="Urbandale, IA"		DIST=	ZIP=50322
	make dealer DEALER=34482   LOCATION="BentonVille, AR"		DIST=	ZIP=72712
	make dealer DEALER=34589   LOCATION="OKLAHOMA CITY, OK"
	make dealer DEALER=34700   LOCATION="NORMAN, OK"
	make dealer DEALER=34706   LOCATION="LAWTON, OK"
	make dealer DEALER=34703   LOCATION="AURORA, CO"			ZIP=80100
	make dealer DEALER=42140   LOCATION="CENTENNIAL, CO"
	make dealer DEALER=41320   LOCATION="LITTLETON, CO"
	make dealer DEALER=34699   LOCATION="LAKEWOOD, CO"
	make dealer DEALER=42025   LOCATION="BROOMFIELD, CO"
	make dealer DEALER=42132   LOCATION="LONGMONT, CO"
	make dealer DEALER=70927   LOCATION="ELLISVILLE, MO"
	make dealer DEALER=70925   LOCATION="ST. LOUIS, MO"
	make dealer DEALER=34581   LOCATION="ST. LOUIS, MO"
	make dealer DEALER=34469   LOCATION="SAINT PETERS, MO"
	make dealer DEALER=61554   LOCATION="SPRINGFIELD, IL"
	make dealer DEALER=61566   LOCATION="SIOUX CITY, IA"
	make dealer DEALER=34541   LOCATION="DODGE CITY, KS"
	make dealer DEALER=70151   LOCATION="OFALLON, IL"
	make dealer DEALER=10707   LOCATION="SIOUX FALLS, SD"
	make dealer DEALER=34428   LOCATION="WICHITA FALLS, TX"
	make dealer DEALER=34622   LOCATION="DENTON, TX"
	make dealer DEALER=34615   LOCATION="CAPE GIRARDEAU, MO"
	make dealer DEALER=34439   LOCATION="WEST BURLINGTON, IA"
	make dealer DEALER=61601   LOCATION="PEORIA, IL"
	make dealer DEALER=61523   LOCATION="BLOOMINGTON, IL"
	make dealer DEALER=61618   LOCATION="URBANA, IL"


tesXt::
	@echo 'ResultsPageSize=12&Vehicle%5BDealerId%5D%5B%5D=$(DEALER)&Vehicle%5BCarline%5D%5B%5D=$(CAR)&Vehicle%5BType%5D%5B%5D=n'
	@echo 'ResultsPageSize=12&Vehicle%5BDealerId%5D%5B%5D=70623&Vehicle%5BCarline%5D%5B%5D=MXR&Vehicle%5BType%5D%5B%5D=n'

test::
	@curl -X POST -s \
		https://www.mazdausa.com/api/inventorysearch \
		-H 'Content-Type: application/x-www-form-urlencoded; charset=UTF-8' \
		-d 'ResultsPageSize=12&Vehicle%5BDealerId%5D%5B%5D=34482Vehicle%5BCarline%5D%5B%5D=MXR&Vehicle%5BType%5D%5B%5D=n'
#		-d 'ResultsPageSize=12&Vehicle%5BDealerId%5D%5B%5D=$(DEALER)&Vehicle%5BCarline%5D%5B%5D=$(CAR)&Vehicle%5BType%5D%5B%5D=n'



dealer::
	@curl -X POST -s \
		https://www.mazdausa.com/api/inventorysearch \
		-H 'Content-Type: application/x-www-form-urlencoded; charset=UTF-8' \
		-d 'ResultsPageSize=12&ResultsParameterFilter=&ResultsSortAttribute=Year&ResultsSortOrder=asc&ResultsStart=1&NearResultsStart=1&TimeSearchPerformed=&Vehicle%5BDealerId%5D%5B%5D=$(DEALER)&Vehicle%5Bcond%5D%5B%5D=c&Vehicle%5BType%5D%5B%5D=c&Vehicle%5BCarline%5D%5B%5D=$(CAR)&Vehicle%5BType%5D%5B%5D=n&Vehicle%5BisDigitalRetail%5D%5B%5D=false&Vehicle%5BsortTitle%5D%5B%5D=Distance%3A+Near+to+Far&GetNearMatch=false&resultsSortParameter%5B0%5D%5BresultsSortAttribute%5D=DEALERID&resultsSortParameter%5B0%5D%5BresultsSortOrder%5D=asc&resultsSortParameter%5B1%5D%5BresultsSortAttribute%5D=price&resultsSortParameter%5B1%5D%5BresultsSortOrder%5D=asc&resultsSortParameter%5B2%5D%5BresultsSortAttribute%5D=Year&resultsSortParameter%5B2%5D%5BresultsSortOrder%5D=desc&resultsSortParameter%5B3%5D%5BresultsSortAttribute%5D=Mileage&resultsSortParameter%5B3%5D%5BresultsSortOrder%5D=asc&sortVal=DEALERID%7Casc%2Cprice%7Casc%2CYear%7Cdesc%2CMileage%7Casc&sortTitle=Distance%3A+Near+to+Far' \
		| jq '.response.Vehicles|map(select(.Model.Transmission.Desc == "Automatic"))|[.[]|{Price, Color:.Colors.MajorExteriorColor, DealerId, DealerName, Mileage, Model:.Model.Name, Trans:.Model.Transmission.Desc, TrimName:.Model.TrimName, Year:.Model.Year, Vin, Availability, Status, Location: "$(LOCATION)"}]'  > X
	@cat X | wc -w
	@cat X >> TMP


render::
	jq flatten -s TMP > cars.json
	jq --color-output . cars.json



bigsearch::
	make search ZIP=66047
	make search ZIP=72712

search::
	curl -s 'https://www.mazdausa.com/handlers/dealer.ajax?zip=$(ZIP)&maxDistance=250' | \
		jq '.body.results|map("ResultsPageSize=12&Vehicle%5BDealerId%5D%5B%5D=" + (.id|tostring) + "&Vehicle%5BCarline%5D%5B%5D=MXR&Vehicle%5BType%5D%5B%5D=n")' | \
	grep , | \
	sed 's/[\" ,]//g' | \
	xargs -n 1 -t curl -X POST -s \
		https://www.mazdausa.com/api/inventorysearch \
		-H "'Content-Type: application/x-www-form-urlencoded; charset=UTF-8'" \
		-d | \
	 jq '.response.Vehicles|map(select(.Model.Transmission.Desc == "Automatic"))|[.[]|{Price, Color:.Colors.MajorExteriorColor, DealerId, DealerName, Mileage, Model:.Model.Name, Trans:.Model.Transmission.Desc, TrimName:.Model.TrimName, Year:.Model.Year, Vin, Availability, Status}]'  > TMP
	jq flatten -s TMP > $(ZIP)-cars.json
	jq --color-output . $(ZIP)-cars.json

#| \
#	  jq -s 'map(response.Vehicles|map(select(.Model.Transmission.Desc == "Automatic"))|[.[]|{Price, Color:.Colors.MajorExteriorColor, DealerId, DealerName, Mileage, Model:.Model.Name, Trans:.Model.Transmission.Desc, TrimName:.Model.TrimName, Year:.Model.Year, Vin, Availability, Status}])' 


foo::
	echo 'ResultsPageSize=12&Vehicle%5BDealerId%5D%5B%5D=70623&Vehicle%5BCarline%5D%5B%5D=MXR&Vehicle%5BType%5D%5B%5D=n' | \
		xargs -n 1 curl -X POST -s \
		https://www.mazdausa.com/api/inventorysearch \
		-H 'Content-Type: application/x-www-form-urlencoded; charset=UTF-8' \
		-d
# ResultsPageSize=12&Vehicle%5BDealerId%5D%5B%5D=$(DEALER)&Vehicle%5BCarline%5D%5B%5D=$(CAR)&Vehicle%5BType%5D%5B%5D=n' |  \




# {id,city,driveDistMi,zip})"

