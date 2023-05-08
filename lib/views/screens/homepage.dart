import 'package:flutter/material.dart';
import 'package:mirror_wall/controller/provider/connect_provider.dart';
import 'package:provider/provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String Url = "https://www.google.com/";
  String selectedOption = "first";
  List<String> bookMark = [];
  List bookMark1 = [];
  List urlbookMark1 = [];
  String urlbookMark = "";

  TextEditingController searchController = TextEditingController();

  InAppWebViewController? inAppWebViewController;
  late PullToRefreshController pullToRefreshController;

  @override
  void initState() {
    super.initState();
    pullToRefreshController = PullToRefreshController(
        options: PullToRefreshOptions(
        ),
        onRefresh: () async {
          await inAppWebViewController?.reload();
        });
    Provider.of<ConnectivityProvider>(context, listen: false)
        .checkInternetConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Browser",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: "first",
                child: Row(
                  children: [
                    const Icon(
                      Icons.bookmark,
                    ),
                    const Text("All BookMarks"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: "Second",
                child: Row(
                  children: [
                    const Icon(Icons.laptop),
                    const Text("Search Engine"),
                  ],
                ),
              ),
            ],
            onSelected: (selectedOption) {
              setState(() {
                selectedOption = selectedOption;
              });
              if (selectedOption == "first") {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return Container(
                      height: 600,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        icon: Icon(
                                          Icons.close,
                                        ),
                                      ),
                                      Text(
                                        "Dismiss",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 10,
                            child: Container(
                              child: (bookMark1.isNotEmpty)
                                  ? ListView.builder(
                                      itemCount: bookMark1.length,
                                      itemBuilder: (context, i) => ListTile(
                                        onTap: (){
                                          setState(() {
                                            inAppWebViewController?.loadUrl(urlRequest: URLRequest(url: bookMark1[i]),);
                                          });
                                          Navigator.of(context).pop();
                                        },
                                        title: Text("${urlbookMark1[i]}"),
                                        subtitle: Text("${bookMark1[i]}"),
                                        trailing: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              bookMark1.remove(bookMark1[i]);
                                              urlbookMark1
                                                  .remove(urlbookMark1[i]);
                                              Navigator.of(context).pop();
                                            });
                                          },
                                          icon: Icon(
                                            Icons.close,
                                          ),
                                        ),
                                      ),
                                    )
                                  : const Center(
                                      child: Text("No any bookmark yet..."),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else if (selectedOption == "Second") {
                setState(() {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Search Engine"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RadioListTile(
                            title: Text("Google"),
                            value: "https://www.google.com/",
                            groupValue: Url,
                            onChanged: (val) {
                              setState(() {
                                searchController.clear();
                                Url = val!;
                              });
                              inAppWebViewController!.loadUrl(
                                urlRequest: URLRequest(
                                  url: Uri.parse(Url),
                                ),
                              );
                              Navigator.of(context).pop();
                            },
                          ),
                          RadioListTile(
                            title: Text("Zara"),
                            value: "https://www.zara.com/in/",
                            groupValue: Url,
                            onChanged: (val) {
                              setState(() {
                                searchController.clear();
                                Url = val!;
                              });
                              inAppWebViewController!.loadUrl(
                                urlRequest: URLRequest(
                                  url: Uri.parse(Url),
                                ),
                              );
                              Navigator.of(context).pop();
                            },
                          ),
                          RadioListTile(
                            title: Text("Bing"),
                            value: "https://www.bing.com/",
                            groupValue: Url,
                            onChanged: (val) {
                              setState(() {
                                searchController.clear();
                                Url = val!;
                              });
                              inAppWebViewController!.loadUrl(
                                urlRequest: URLRequest(
                                  url: Uri.parse(Url),
                                ),
                              );
                              Navigator.of(context).pop();
                            },
                          ),
                          RadioListTile(
                            title: Text("H&M"),
                            value: "https://www2.hm.com/en_in/index.html",
                            groupValue: Url,
                            onChanged: (val) {
                              setState(() {
                                searchController.clear();
                                Url = val!;
                              });
                              inAppWebViewController!.loadUrl(
                                urlRequest: URLRequest(
                                  url: Uri.parse(Url),
                                ),
                              );
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                });
              }
            },
          ),
        ],
      ),
      body: (Provider.of<ConnectivityProvider>(context)
                  .connectivityModel
                  .status ==
              "Waiting")
          ? Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 250,
                  ),
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Offline",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  flex: 18,
                  child: InAppWebView(
                    pullToRefreshController: pullToRefreshController,
                    onWebViewCreated: (controller) {
                      inAppWebViewController = controller;
                    },
                    onLoadStart: (controller, url) {
                      setState(() {
                        inAppWebViewController = controller;
                        urlbookMark = url.toString();
                      });
                    },
                    onLoadStop: (controller, url) async {
                      await pullToRefreshController.endRefreshing();
                    },
                    initialUrlRequest: URLRequest(
                      url: Uri.parse(Url),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                              hintText: "Search or type Web address",
                              border: OutlineInputBorder(),
                              suffixIcon: IconButton(
                                icon: const Icon(
                                  Icons.search,
                                ),
                                onPressed: () {
                                  String newLink = searchController.text;
                                  inAppWebViewController?.loadUrl(
                                    urlRequest: URLRequest(
                                      url: Uri.parse("${Url}search?q=$newLink"),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                onPressed: () async {
                                  await inAppWebViewController?.loadUrl(
                                    urlRequest: URLRequest(
                                      url: Uri.parse(Url),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.home,
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  urlbookMark1.add(
                                    await inAppWebViewController?.getTitle(),
                                  );
                                  bookMark1.add(
                                    await inAppWebViewController?.getUrl(),
                                  );
                                },
                                icon: Icon(
                                  Icons.bookmark_add_outlined,
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  if (await inAppWebViewController!
                                      .canGoBack()) {
                                    await inAppWebViewController?.goBack();
                                  }
                                },
                                icon: Icon(
                                  Icons.arrow_back_ios_outlined,
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  await inAppWebViewController?.reload();
                                },
                                icon: Icon(
                                  Icons.refresh,
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  if (await inAppWebViewController!
                                      .canGoForward()) {
                                    await inAppWebViewController?.goForward();
                                  }
                                },
                                icon: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
