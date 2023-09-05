class RouterConfiguration {
  RouterConfiguration.init();

  final String kRootRoute = '/';
  final authRoutes = const _AuthRoutes._();
  final homeRoutes = const _HomeRoutes._();
  final productRoutes = const _ProductRoutes._();
  final profileRoutes = const _ProfileRoutes._();
  final notificationRoutes = const _NotificationRoutes._();


}

class _AuthRoutes{
  const _AuthRoutes._();

  final String login = '/login';
  final String forgerPassword = '/forgerPassword';
}

class _HomeRoutes{
  const _HomeRoutes._();

  final String homeScreen = '/homeScreen';
  final String orderDetailScreen = 'OrderDetailScreen';
  final String orderDetail = 'OrderDetail';
  final String orderDone='OrderDone';
}
class _ProductRoutes{
  const _ProductRoutes._();

  final String productScreen = '/productScreen';
}
class _ProfileRoutes{
  const _ProfileRoutes._();

  final String profileScreen = '/ProfileScreen';
  final String changePasswordScreen = 'ChangePasswordScreen';
}
class _NotificationRoutes{
  const _NotificationRoutes._();

  final String notificationScreen = '/NotificationScreen';
}

