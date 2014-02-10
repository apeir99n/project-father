'use strict'

app = angular.module 'pfather', ['ngRoute']

app.controller 'MainCtrl', ['$scope', '$http', ($scope, $http) ->
  $scope.step = 1

  $http.get('/data/users.json').success (users) ->
    $scope.users = users

  $http.get('/data/questions.json').success (questions) ->
    $scope.questions = questions

  findUser = (id) ->
    fUsers = $scope.users.filter (q) -> q.id is id
    fUsers[0]

  findUserDetails = (id) ->
    fUsers = $scope.questions.filter (u) -> u.id is id
    fUsers[0]

  $scope.showDetails = (id) ->
    console.log id
    user = findUser id
    users = []
    findParents = (user) ->
      if user.parent
        parent = findUser user.parent
        findParents parent
        users.push parent
    findChildren = (user) ->
      if user.child
        child = findUser user.child
        users.push child
        findChildren child
    findParents user
    users.push user
    findChildren user
    console.log users

    dUsers = users.map (user) -> user: user, details: findUserDetails user.id
    console.log dUsers

    $scope.dUsers = dUsers
    $scope.step = 2

  $scope.toggleStep = ->
    console.log $scope.step
    if $scope.step is 2
      $scope.step = 1
    else
      $scope.step = 2
]

