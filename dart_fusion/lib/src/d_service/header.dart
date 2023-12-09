part of '../../dart_fusion.dart';

/// Abstract class representing headers used in CORS policies.
abstract class Header extends DModel {
  const Header();

  @override
  String toString() {
    final type = toJSON.of<String>('model_type');
    return type.split(RegExp('(?=[A-Z])')).join('-');
  }

  static Header fromJSON(JSON value) {
    switch (value.of<String>('model_type')) {
      case 'Accept':
        return const Accept();
      case 'AcceptLanguage':
        return const AcceptLanguage();
      case 'ContentLanguage':
        return const ContentLanguage();
      case 'ContentType':
        return const ContentType();
      case 'Authorization':
        return const Authorization();
      case 'Origin':
        return const Origin();
      case 'XRequestedWith':
        return const XRequestedWith();
      case 'AccessControlRequestMethod':
        return const AccessControlRequestMethod();
      case 'AccessControlRequestHeaders':
        return const AccessControlRequestHeaders();
      case 'AcceptCharset':
        return const AcceptCharset();
      case 'AcceptEncoding':
        return const AcceptEncoding();
      case 'AcceptRanges':
        return const AcceptRanges();
      case 'AccessControlAllowCredentials':
        return const AccessControlAllowCredentials();
      case 'AccessControlAllowHeaders':
        return const AccessControlAllowHeaders();
      case 'AccessControlAllowMethods':
        return const AccessControlAllowMethods();
      case 'AccessControlExposeHeaders':
        return const AccessControlExposeHeaders();
      case 'AccessControlMaxAge':
        return const AccessControlMaxAge();
      case 'Age':
        return const Age();
      case 'Allow':
        return const Allow();
      case 'ContentDisposition':
        return const ContentDisposition();
      case 'ContentEncoding':
        return const ContentEncoding();
      case 'ContentLocation':
        return const ContentLocation();
      case 'ContentRange':
        return const ContentRange();
      case 'ContentSecurityPolicy':
        return const ContentSecurityPolicy();
      case 'ContentSecurityPolicyReportOnly':
        return const ContentSecurityPolicyReportOnly();
      case 'DateHeader':
        return const DateHeader();
      case 'ETag':
        return const ETag();
      case 'Expires':
        return const Expires();
      case 'LastModified':
        return const LastModified();
      case 'Tk':
        return const Tk();
      case 'Trailer':
        return const Trailer();
      case 'TransferEncoding':
        return const TransferEncoding();
      case 'Vary':
        return const Vary();
      case 'Via':
        return const Via();
      case 'Warning':
        return const Warning();
      case 'WWWAuthenticate':
        return const WWWAuthenticate();
      case 'XFrameOptions':
        return const XFrameOptions();
      case 'XPoweredBy':
        return const XPoweredBy();
      case 'XUACompatible':
        return const XUACompatible();
      case 'XContentTypeOptions':
        return const XContentTypeOptions();
      case 'XDNSPrefetchControl':
        return const XDNSPrefetchControl();
      case 'XDownloadOptions':
        return const XDownloadOptions();
      case 'XPermittedCrossDomainPolicies':
        return const XPermittedCrossDomainPolicies();
      case 'XRedirectBy':
        return const XRedirectBy();
      case 'XRobotsTag':
        return const XRobotsTag();
      case 'XXSSProtection':
        return const XXSSProtection();
      case 'Refresh':
        return const Refresh();
      case 'ReportTo':
        return const ReportTo();
      case 'SecFetchSite':
        return const SecFetchSite();
      case 'SecFetchMode':
        return const SecFetchMode();
      case 'SecFetchDest':
        return const SecFetchDest();
      case 'SecFetchUser':
        return const SecFetchUser();
      case 'SecFetchCredentials':
        return const SecFetchCredentials();
      case 'SecFetchCache':
        return const SecFetchCache();
      case 'SecFetchPriority':
        return const SecFetchPriority();
      case 'SecFetchFrameOptions':
        return const SecFetchFrameOptions();
      case 'SecFetchVersion':
        return const SecFetchVersion();
      case 'SecWebSocketKey':
        return const SecWebSocketKey();
      case 'SecWebSocketExtensions':
        return const SecWebSocketExtensions();
      case 'SecWebSocketAccept':
        return const SecWebSocketAccept();
      case 'SecWebSocketProtocol':
        return const SecWebSocketProtocol();
      case 'SecWebSocketVersion':
        return const SecWebSocketVersion();
      case 'SecWebSocketVersionKey':
        return const SecWebSocketVersionKey();
      case 'SecWebSocketVersionOrigin':
        return const SecWebSocketVersionOrigin();
      case 'SecWebSocketVersionLocation':
        return const SecWebSocketVersionLocation();
      case 'SecWebSocketVersionId':
        return const SecWebSocketVersionId();
      case 'SecWebSocketVersionParentId':
        return const SecWebSocketVersionParentId();
      case 'SecWebSocketVersionNonce':
        return const SecWebSocketVersionNonce();
      case 'XWebKitCSP':
        return const XWebKitCSP();
      case 'XPermittedCrossDomainPolicy':
        return const XPermittedCrossDomainPolicy();
      case 'XSourceMap':
        return const XSourceMap();
      case 'XForwardedProto':
        return const XForwardedProto();
      case 'XForwardedFor':
        return const XForwardedFor();
      case 'XForwardedHost':
        return const XForwardedHost();
      case 'XForwardedServer':
        return const XForwardedServer();
      case 'XRealIP':
        return const XRealIP();
      case 'XFrameOptionsType':
        return const XFrameOptionsType();
      case 'XFrameOptionsAllowFrom':
        return const XFrameOptionsAllowFrom();
      case 'XFrameOptionsDeny':
        return const XFrameOptionsDeny();
      case 'XContentDuration':
        return const XContentDuration();
      case 'XContentSecurityPolicy':
        return const XContentSecurityPolicy();
      case 'XContentSecurityPolicyReportOnly':
        return const XContentSecurityPolicyReportOnly();
      case 'XCorrelationID':
        return const XCorrelationID();
      case 'XDeviceUserAgent':
        return const XDeviceUserAgent();
      case 'XForwardedScheme':
        return const XForwardedScheme();
      case 'XForwardedSSL':
        return const XForwardedSSL();
      case 'XForwardedSslClientCert':
        return const XForwardedSslClientCert();
      case 'XForwardedSslClientCertInfo':
        return const XForwardedSslClientCertInfo();
      case 'XHTTPMethod':
        return const XHTTPMethod();
      case 'XRequestID':
        return const XRequestID();
      case 'XResponseTime':
        return const XResponseTime();
      case 'XUIDH':
        return const XUIDH();
      case 'XWapProfile':
        return const XWapProfile();
      case 'XWebKitCSPReportOnly':
        return const XWebKitCSPReportOnly();
      case 'XXSRFToken':
        return const XXSRFToken();
      case 'XZoneDebug':
        return const XZoneDebug();
      default:
        return const ContentType();
    }
  }

  static const Accept accept = Accept();
  static const AcceptLanguage acceptLanguage = AcceptLanguage();
  static const ContentLanguage contentLanguage = ContentLanguage();
  static const ContentType contentType = ContentType();
  static const Authorization authorization = Authorization();
  static const Origin origin = Origin();
  static const XRequestedWith xRequestedWith = XRequestedWith();
  static const AccessControlRequestMethod accessControlRequestMethod =
      AccessControlRequestMethod();
  static const AccessControlRequestHeaders accessControlRequestHeaders =
      AccessControlRequestHeaders();
  static const AcceptCharset acceptCharset = AcceptCharset();
  static const AcceptEncoding acceptEncoding = AcceptEncoding();
  static const AcceptRanges acceptRanges = AcceptRanges();
  static const AccessControlAllowCredentials accessControlAllowCredentials =
      AccessControlAllowCredentials();
  static const AccessControlAllowHeaders accessControlAllowHeaders =
      AccessControlAllowHeaders();
  static const AccessControlAllowMethods accessControlAllowMethods =
      AccessControlAllowMethods();
  static const AccessControlExposeHeaders accessControlExposeHeaders =
      AccessControlExposeHeaders();
  static const AccessControlMaxAge accessControlMaxAge = AccessControlMaxAge();
  static const Age age = Age();
  static const Allow allow = Allow();
  static const ContentDisposition contentDisposition = ContentDisposition();
  static const ContentEncoding contentEncoding = ContentEncoding();
  static const ContentLocation contentLocation = ContentLocation();
  static const ContentRange contentRange = ContentRange();
  static const ContentSecurityPolicy contentSecurityPolicy =
      ContentSecurityPolicy();
  static const ContentSecurityPolicyReportOnly contentSecurityPolicyReportOnly =
      ContentSecurityPolicyReportOnly();
  static const DateHeader dateHeader = DateHeader();
  static const ETag eTag = ETag();
  static const Expires expires = Expires();
  static const LastModified lastModified = LastModified();
  static const Tk tk = Tk();
  static const Trailer trailer = Trailer();
  static const TransferEncoding transferEncoding = TransferEncoding();
  static const Vary vary = Vary();
  static const Via via = Via();
  static const Warning warning = Warning();
  static const WWWAuthenticate wwwAuthenticate = WWWAuthenticate();
  static const XFrameOptions xFrameOptions = XFrameOptions();
  static const XPoweredBy xPoweredBy = XPoweredBy();
  static const XUACompatible xUACompatible = XUACompatible();
  static const XContentTypeOptions xContentTypeOptions = XContentTypeOptions();
  static const XDNSPrefetchControl xDNSPrefetchControl = XDNSPrefetchControl();
  static const XDownloadOptions xDownloadOptions = XDownloadOptions();
  static const XPermittedCrossDomainPolicies xPermittedCrossDomainPolicies =
      XPermittedCrossDomainPolicies();
  static const XRedirectBy xRedirectBy = XRedirectBy();
  static const XRobotsTag xRobotsTag = XRobotsTag();
  static const XXSSProtection xXSSProtection = XXSSProtection();
  static const Refresh refresh = Refresh();
  static const ReportTo reportTo = ReportTo();
  static const SecFetchSite secFetchSite = SecFetchSite();
  static const SecFetchMode secFetchMode = SecFetchMode();
  static const SecFetchDest secFetchDest = SecFetchDest();
  static const SecFetchUser secFetchUser = SecFetchUser();
  static const SecFetchCredentials secFetchCredentials = SecFetchCredentials();
  static const SecFetchCache secFetchCache = SecFetchCache();
  static const SecFetchPriority secFetchPriority = SecFetchPriority();
  static const SecFetchFrameOptions secFetchFrameOptions =
      SecFetchFrameOptions();
  static const SecFetchVersion secFetchVersion = SecFetchVersion();
  static const SecWebSocketKey secWebSocketKey = SecWebSocketKey();
  static const SecWebSocketExtensions secWebSocketExtensions =
      SecWebSocketExtensions();
  static const SecWebSocketAccept secWebSocketAccept = SecWebSocketAccept();
  static const SecWebSocketProtocol secWebSocketProtocol =
      SecWebSocketProtocol();
  static const SecWebSocketVersion secWebSocketVersion = SecWebSocketVersion();
  static const SecWebSocketVersionKey secWebSocketVersionKey =
      SecWebSocketVersionKey();
  static const SecWebSocketVersionOrigin secWebSocketVersionOrigin =
      SecWebSocketVersionOrigin();
  static const SecWebSocketVersionLocation secWebSocketVersionLocation =
      SecWebSocketVersionLocation();
  static const SecWebSocketVersionId secWebSocketVersionId =
      SecWebSocketVersionId();
  static const SecWebSocketVersionParentId secWebSocketVersionParentId =
      SecWebSocketVersionParentId();
  static const SecWebSocketVersionNonce secWebSocketVersionNonce =
      SecWebSocketVersionNonce();
  static const XWebKitCSP xWebKitCSP = XWebKitCSP();
  static const XPermittedCrossDomainPolicy xPermittedCrossDomainPolicy =
      XPermittedCrossDomainPolicy();
  static const XSourceMap xSourceMap = XSourceMap();
  static const XForwardedProto xForwardedProto = XForwardedProto();
  static const XForwardedFor xForwardedFor = XForwardedFor();
  static const XForwardedHost xForwardedHost = XForwardedHost();
  static const XForwardedServer xForwardedServer = XForwardedServer();
  static const XRealIP xRealIP = XRealIP();
  static const XFrameOptionsType xFrameOptionsType = XFrameOptionsType();
  static const XFrameOptionsAllowFrom xFrameOptionsAllowFrom =
      XFrameOptionsAllowFrom();
  static const XFrameOptionsDeny xFrameOptionsDeny = XFrameOptionsDeny();
  static const XContentDuration xContentDuration = XContentDuration();
  static const XContentSecurityPolicy xContentSecurityPolicy =
      XContentSecurityPolicy();
  static const XContentSecurityPolicyReportOnly
      xContentSecurityPolicyReportOnly = XContentSecurityPolicyReportOnly();
  static const XCorrelationID xCorrelationID = XCorrelationID();
  static const XDeviceUserAgent xDeviceUserAgent = XDeviceUserAgent();
  static const XForwardedScheme xForwardedScheme = XForwardedScheme();
  static const XForwardedSSL xForwardedSSL = XForwardedSSL();
  static const XForwardedSslClientCert xForwardedSslClientCert =
      XForwardedSslClientCert();
  static const XForwardedSslClientCertInfo xForwardedSslClientCertInfo =
      XForwardedSslClientCertInfo();
  static const XHTTPMethod xHTTPMethod = XHTTPMethod();
  static const XRequestID xRequestID = XRequestID();
  static const XResponseTime xResponseTime = XResponseTime();
  static const XUIDH xUIDH = XUIDH();
  static const XWapProfile xWapProfile = XWapProfile();
  static const XWebKitCSPReportOnly xWebKitCSPReportOnly =
      XWebKitCSPReportOnly();
  static const XXSRFToken xXSRFToken = XXSRFToken();
  static const XZoneDebug xZoneDebug = XZoneDebug();
}

class Accept extends Header {
  const Accept();
}

class AcceptLanguage extends Header {
  const AcceptLanguage();
}

class ContentLanguage extends Header {
  const ContentLanguage();
}

class ContentType extends Header {
  const ContentType();
}

class Authorization extends Header {
  const Authorization();
}

class Origin extends Header {
  const Origin();
}

class XRequestedWith extends Header {
  const XRequestedWith();
}

class AccessControlRequestMethod extends Header {
  const AccessControlRequestMethod();
}

class AccessControlRequestHeaders extends Header {
  const AccessControlRequestHeaders();
}

class AcceptCharset extends Header {
  const AcceptCharset();
}

class AcceptEncoding extends Header {
  const AcceptEncoding();
}

class AcceptRanges extends Header {
  const AcceptRanges();
}

class AccessControlAllowCredentials extends Header {
  const AccessControlAllowCredentials();
}

class AccessControlAllowHeaders extends Header {
  const AccessControlAllowHeaders();
}

class AccessControlAllowMethods extends Header {
  const AccessControlAllowMethods();
}

class AccessControlExposeHeaders extends Header {
  const AccessControlExposeHeaders();
}

class AccessControlMaxAge extends Header {
  const AccessControlMaxAge();
}

class Age extends Header {
  const Age();
}

class Allow extends Header {
  const Allow();
}

class ContentDisposition extends Header {
  const ContentDisposition();
}

class ContentEncoding extends Header {
  const ContentEncoding();
}

class ContentLocation extends Header {
  const ContentLocation();
}

class ContentRange extends Header {
  const ContentRange();
}

class ContentSecurityPolicy extends Header {
  const ContentSecurityPolicy();
}

class ContentSecurityPolicyReportOnly extends Header {
  const ContentSecurityPolicyReportOnly();
}

class DateHeader extends Header {
  const DateHeader();
}

class ETag extends Header {
  const ETag();

  @override
  String toString() => 'ETag';
}

class Expires extends Header {
  const Expires();
}

class LastModified extends Header {
  const LastModified();
}

class Tk extends Header {
  const Tk();
}

class Trailer extends Header {
  const Trailer();
}

class TransferEncoding extends Header {
  const TransferEncoding();
}

class Vary extends Header {
  const Vary();
}

class Via extends Header {
  const Via();
}

class Warning extends Header {
  const Warning();
}

class WWWAuthenticate extends Header {
  const WWWAuthenticate();
}

class XFrameOptions extends Header {
  const XFrameOptions();
}

class XPoweredBy extends Header {
  const XPoweredBy();
}

class XUACompatible extends Header {
  const XUACompatible();
}

class XContentTypeOptions extends Header {
  const XContentTypeOptions();
}

class XDNSPrefetchControl extends Header {
  const XDNSPrefetchControl();
}

class XDownloadOptions extends Header {
  const XDownloadOptions();
}

class XPermittedCrossDomainPolicies extends Header {
  const XPermittedCrossDomainPolicies();
}

class XRedirectBy extends Header {
  const XRedirectBy();
}

class XRobotsTag extends Header {
  const XRobotsTag();
}

class XXSSProtection extends Header {
  const XXSSProtection();
}

class Refresh extends Header {
  const Refresh();
}

class ReportTo extends Header {
  const ReportTo();
}

class SecFetchSite extends Header {
  const SecFetchSite();
}

class SecFetchMode extends Header {
  const SecFetchMode();
}

class SecFetchDest extends Header {
  const SecFetchDest();
}

class SecFetchUser extends Header {
  const SecFetchUser();
}

class SecFetchCredentials extends Header {
  const SecFetchCredentials();
}

class SecFetchCache extends Header {
  const SecFetchCache();
}

class SecFetchPriority extends Header {
  const SecFetchPriority();
}

class SecFetchFrameOptions extends Header {
  const SecFetchFrameOptions();
}

class SecFetchVersion extends Header {
  const SecFetchVersion();
}

class SecWebSocketKey extends Header {
  const SecWebSocketKey();
}

class SecWebSocketExtensions extends Header {
  const SecWebSocketExtensions();
}

class SecWebSocketAccept extends Header {
  const SecWebSocketAccept();
}

class SecWebSocketProtocol extends Header {
  const SecWebSocketProtocol();
}

class SecWebSocketVersion extends Header {
  const SecWebSocketVersion();
}

class SecWebSocketVersionKey extends Header {
  const SecWebSocketVersionKey();
}

class SecWebSocketVersionOrigin extends Header {
  const SecWebSocketVersionOrigin();
}

class SecWebSocketVersionLocation extends Header {
  const SecWebSocketVersionLocation();
}

class SecWebSocketVersionId extends Header {
  const SecWebSocketVersionId();
}

class SecWebSocketVersionParentId extends Header {
  const SecWebSocketVersionParentId();
}

class SecWebSocketVersionNonce extends Header {
  const SecWebSocketVersionNonce();
}

class XWebKitCSP extends Header {
  const XWebKitCSP();
}

class XPermittedCrossDomainPolicy extends Header {
  const XPermittedCrossDomainPolicy();
}

class XSourceMap extends Header {
  const XSourceMap();
}

class XForwardedProto extends Header {
  const XForwardedProto();
}

class XForwardedFor extends Header {
  const XForwardedFor();
}

class XForwardedHost extends Header {
  const XForwardedHost();
}

class XForwardedServer extends Header {
  const XForwardedServer();
}

class XRealIP extends Header {
  const XRealIP();
}

class XFrameOptionsType extends Header {
  const XFrameOptionsType();
}

class XFrameOptionsAllowFrom extends Header {
  const XFrameOptionsAllowFrom();
}

class XFrameOptionsDeny extends Header {
  const XFrameOptionsDeny();
}

class XContentDuration extends Header {
  const XContentDuration();
}

class XContentSecurityPolicy extends Header {
  const XContentSecurityPolicy();
}

class XContentSecurityPolicyReportOnly extends Header {
  const XContentSecurityPolicyReportOnly();
}

class XCorrelationID extends Header {
  const XCorrelationID();
}

class XDeviceUserAgent extends Header {
  const XDeviceUserAgent();
}

class XForwardedScheme extends Header {
  const XForwardedScheme();
}

class XForwardedSSL extends Header {
  const XForwardedSSL();
}

class XForwardedSslClientCert extends Header {
  const XForwardedSslClientCert();
}

class XForwardedSslClientCertInfo extends Header {
  const XForwardedSslClientCertInfo();
}

class XHTTPMethod extends Header {
  const XHTTPMethod();
}

class XRequestID extends Header {
  const XRequestID();
}

class XResponseTime extends Header {
  const XResponseTime();
}

class XUIDH extends Header {
  const XUIDH();

  @override
  String toString() => 'X-UIDH';
}

class XWapProfile extends Header {
  const XWapProfile();
}

class XWebKitCSPReportOnly extends Header {
  const XWebKitCSPReportOnly();
}

class XXSRFToken extends Header {
  const XXSRFToken();
}

class XZoneDebug extends Header {
  const XZoneDebug();
}
