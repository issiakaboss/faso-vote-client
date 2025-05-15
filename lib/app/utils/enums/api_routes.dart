enum ApiRoutes {
  // auth
  login('v1/app/login'),
  register('v1/app/register'),
  logout('v1/app/logout'),
  storeSecret('v1/app/store-secret'),
  storePhone('v1/app/phones'),
  removePhone('v1/app/phones/{phone}/delete'),
  refreshWithSecret('v1/app/refresh-with-secret'),
  resendOtp('v1/app/phones/{phone_id}/resend-otp'),
  verifyOtp('v1/app/phones/{phone_id}/verify/{code}'),
// transactions actions
  depositMethods('v1/app/transactions/deposit-methods'),
  storeDeposit('v1/app/transactions/store-deposit'),
  storeWithdraw('v1/app/transactions/store-withdraw/{phone}'),
  transfert('v1/app/transactions/store-transfert'),
  generateOtp('v1/app/transactions/generate-payment'),
// transaction fetching data
  walletData('v1/app/transactions/card'),
  transactionHistory('v1/app/transactions/{type}/histories?page={pageKey}'),
//get transaction type
  transactionsTypes('v1/app/transactions/types'),
  deletePendingPayment('v1/app/transactions/{pendingPayment}/delete'),
  pendingPayments('v1/app/transactions/pending-payments');

  final String path;
  const ApiRoutes(this.path);

  /// Remplace les valeurs dynamiques dans l'URL
  String format(Map<String, String> params) {
    String formattedPath = path;
    params.forEach((key, value) {
      formattedPath = formattedPath.replaceAll('{$key}', value);
    });
    return formattedPath;
  }
}
