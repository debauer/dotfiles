function FindProxyForURL(url, host) {
  if (dnsDomainIs(host, ".honda-ri.de")) {
    return "SOCKS5 localhost:1080;";
  }
  if (dnsDomainIs(host, ".guse-it.com")) {
    return "SOCKS5 localhost:4444;";
  }
  return "DIRECT";
}
