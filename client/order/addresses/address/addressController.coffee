controller = (listOfCountries, listOfCities) ->
  ctrl = @
  ctrl.countries = listOfCountries
  ctrl.cities = listOfCities
  ctrl

controller.$inject = ["listOfCountries", "listOfCities"]

module.exports = controller