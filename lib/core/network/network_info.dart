// Optional: check whether the device has network connectivity
// For simplicity we return true. If you want, add connectivity_plus to actually check.
class NetworkInfo {
  Future<bool> get isConnected async {
    // TODO: integrate 'connectivity_plus' to check real connectivity
    return true;
  }
}
