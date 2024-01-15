enum RouteNames {
  // Auth
  login('/login', name: '/login'),
  registration('/registration', name: '/registration'),
  sms('/sms', name: '/sms'),

  password('/password', name: '/password'),
  welcome('/welcome', name: '/welcome'),

  dashboard('/dashboard', name: '/dashboard'),

  // cattle list
  cattleList('/cattle_list', name: '/cattle_list'),
  cattleListFilter('/cattle_list_filter', name: '/cattle_list_filter'),
  addCattle('add_cattle', name: 'add_cattle'),

  // events 
  events('/events', name: '/events'),
  internalMovements('internal_movements', name: 'internal_movements'),
  prevention('prevention', name: 'prevention'),
  treatment('treatment', name: 'treatment'),
  weight('weight', name: 'weight'),
  sales('sales', name: 'sales'),
  slaughter('slaughter', name: 'slaughter'),
  loss('loss', name: 'loss'),
  pregnancy('pregnancy', name: 'pregnancy'),

  map('/map', name: '/map'),
  profile('/profile', name: '/profile');

  const RouteNames(this.path, {required this.name});

  final String path;
  final String name;
}
