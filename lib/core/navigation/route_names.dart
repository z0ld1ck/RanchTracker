enum RouteNames {
  // Auth
  login('/login', name: '/login'),
  registration('/registration', name: '/registration'),
  sms('/sms', name: '/sms'),

  password('/password', name: '/password'),
  welcome('/welcome', name: '/welcome'),

  dashboard('/dashboard', name: '/dashboard'),

  // livestock list
  livestockList('/livestock_list', name: '/livestock_list'),
  livestockListFilter('/livestock_list_filter', name: '/livestock_list_filter'),
  addLivestock('add_livestock', name: 'add_livestock'),

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
