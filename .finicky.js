module.exports = {
    defaultBrowser: "Brave Browser",
    options: {
        // Hide the finicky icon from the top bar. Default: false
        hideIcon: false,
        // Check for update on startup. Default: true
        checkForUpdate: true,
        // Change the internal list of url shortener services. Default: undefined
        //urlShorteners: (list) => [...list, "custom.urlshortener.com"],
        // Log every request with basic information to console. Default: false
        logRequests: false
    },
    handlers: [
        {
            match: [/docs\.google\.com/, /docusign\.net/],
            browser: "Google Chrome"
        },
    ]
};
