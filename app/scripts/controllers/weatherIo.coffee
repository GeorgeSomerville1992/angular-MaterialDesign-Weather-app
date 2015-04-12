
angular.module 'weatherIoAppCoffeeApp'
	.constant 'GOOGLEGEOCODE', 
		"APIKEY":"AIzaSyBDi56DVodoH92MNTpQfcPtloDx0y8CgY8"
		"MAPOPTIONS":
        zoom: 12                    #hostel based on what user has typed in
        center: 
        	lat: 51.4147407
        	lng: -0.7000339999999999
	.constant 'WEATHERIO',
		"APIKEY":"f271ac1c5ceccc30508c42ee76ddb21b"
	.constant 'WEEKDAYCONSTANT',
		"WEEKDAY": ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday']
		"INCREMENT": 2
	.controller 'WeatherIoCoffeeCtrl',['$scope','$http','GOOGLEGEOCODE','WEATHERIO', 'WEEKDAYCONSTANT','$mdSidenav', ($scope,$http,GOOGLEGEOCODE,WEATHERIO,WEEKDAYCONSTANT,$mdSidenav) ->
		$scope.savedLocations = [
			{name:"George",postCode:"SL58HZ"}
		]
		$scope.weatherSummary = "Enter your postcode"
		$scope.currentWeather = []
		console.log("gogogogogogooGOOOO")
		$scope.submitRequest = ->
			query = postCode:$scope.postCode, name:$scope.name
			$scope.savedLocations.push query
			console.log($scope.savedLocations)
			$scope.geocodeLocation(query.postCode)

		$scope.getLocation = ->

		  showPosition = (position) ->
		    $scope.getWeather position.coords.latitude, position.coords.longitude
		    return

		  if navigator.geolocation
		    navigator.geolocation.getCurrentPosition showPosition
		  return

		$scope.geocodeLocation = (postCode) ->
			$http.get("https://maps.googleapis.com/maps/api/geocode/json?address="+postCode+"&sensor=false&key="+GOOGLEGEOCODE.APIKEY).success (data) ->
				resultLat = data.results[0].geometry.location.lat
				resultLng = data.results[0].geometry.location.lng
				console.log(data)
				map_container = document.getElementById('locationMap')
				$scope.getWeather resultLat, resultLng
		$scope.getWeather = (latPoint, longPoint) ->
			$http.get("https://api.forecast.io/forecast/"+WEATHERIO.APIKEY+"/"+latPoint+","+longPoint).success (data) ->
				$scope.weatherSummary = data.daily.summary
				sevenDayFourcast = data.daily.data
				$scope.displayWeather(sevenDayFourcast)
		$scope.displayWeather = (sevenDayFourcast)->
			$scope.currentWeather = []
			WEEKDAYCONSTANT.INCREMENT = 4	
			angular.forEach sevenDayFourcast, (day, key) ->
				n = WEEKDAYCONSTANT.WEEKDAY[WEEKDAYCONSTANT.INCREMENT]
				WEEKDAYCONSTANT.INCREMENT+=1
				if WEEKDAYCONSTANT.INCREMENT == 7
					WEEKDAYCONSTANT.INCREMENT = 0
				savedDay =
						cloudCover:day.cloudCover * 100
						humidity:day.humidity
						icon:day.icon
						temperatureMax:day.temperatureMax
						windBearing:day.windBearing
						windSpeed:day.windSpeed
						summary:day.summary
						weekday:n
					$scope.currentWeather.push(savedDay)
			# now that I've got in the array, create a new array with loop based on this length...
			$scope.addSquares()			
			# console.log($scope.currentWeather)
		$scope.addSquares = ->
			it = $scope.currentWeather.splice(1,7)
			it.splice(1,0,"weatherSummary":$scope.weatherSummary)
			#need to resort the array so the first day(which will be tomorrow) will actually be in the place 
			# where the larger square is. 
			console.log(it)
			results = []
			j = 0
			console.log("FINAL IT ARRAY",it)
			#push this icon hash into it at the end.
			while j < it.length
				increment = j + 1
				console.log("INCREMENT", increment)
				it[j].title = "Svg" + increment
				it[j].span = 
									col:1
									row:1
				it[j].background = "cyan"
				it[j].clicked = ""
				switch j+1
					when 2
						it[j].span.col=2
						it[j].span.row=2
						it[j].background="#D5425D"
						console.log("SEVEN",it[j])
					when 7 # oringially 7
						it[j].weekday="TOMORROW"
						it[j].span.col=2
						it[j].span.row=1
					when 8
						it[j].background = "purple"

				j++ 
			$scope.currentWeather = it
			console.log($scope.currentWeather)
	]

