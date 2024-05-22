class AppUrls {
  String networkUrl = "https://jsonplaceholder.typicode.com/";
}

Map<String, String> getHeaders() {
  return {
    "Content-Type": "application/json",
  };
}

AppUrls appUrls = AppUrls();

Uri baseUrl({required String endPoint}) {
  return Uri.parse(appUrls.networkUrl + endPoint);
}

final List<String> morningList = [
  "12:00 am - 01:00 am",
  "01:00 am - 02:00 am",
  "02:00 am - 03:00 am",
  "03:00 am - 04:00 am",
  "04:00 am - 05:00 am",
  "05:00 am - 06:00 am",
  "06:00 am - 07:00 am",
  "07:00 am - 08:00 am",
  "08:00 am - 09:00 am",
  "09:00 am - 10:00 am",
  "10:00 am - 11:00 am",
  "11:00 am - 12:00 pm",
];

final List<String> afternoonList = [
  "12:00 pm - 01:00 pm",
  "01:00 pm - 02:00 pm",
  "02:00 pm - 03:00 pm",
  "03:00 pm - 04:00 pm",
  "04:00 pm - 05:00 pm",
  "05:00 pm - 06:00 pm",
  "06:00 pm - 07:00 pm",
  "07:00 pm - 08:00 pm",
  "08:00 pm - 09:00 pm",
  "09:00 pm - 10:00 pm",
  "10:00 pm - 11:00 pm",
];
