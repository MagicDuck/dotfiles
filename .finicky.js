export default {
  // defaultBrowser: "Brave Browser",
  // defaultBrowser: "Safari",
  defaultBrowser: "Vivaldi",
  options: {
    // Hide the finicky icon from the top bar. Default: false
    hideIcon: true,
    // Check for update on startup. Default: true
    checkForUpdate: true,
    // Change the internal list of url shortener services. Default: undefined
    //urlShorteners: (list) => [...list, "custom.urlshortener.com"],
    // Log every request with basic information to console. Default: false
    logRequests: false,
  },
  handlers: [
    {
      match: [/developers\.everbridge\.net/],
      browser: "Vivaldi",
    },
    {
      match: [
        /docs\.google\.com/,
        /docusign\.net/,
        /testrail\.i\.xmatters\.com/,
        /datastudio\.google\.com/,
        /accounts\.google\.com/,
        /accounts\.google\.com/,
        /everbridge\.net/,
        /xmatters\.com/,
        /xmatters\.splunkcloud\.com/,
      ],
      browser: "Google Chrome",
    },
  ],
};
