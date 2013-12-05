angular.module('astrosonnetApp')
.filter 'orderObjectBy', ->
  return (items, field, reverse) ->
    filtered = []

    angular.forEach items, (item) ->
      filtered.push(item)

    filtered.sort (a, b) -> 
      return (a[field] > b[field])

    filtered.reverse() if reverse
    
    return filtered