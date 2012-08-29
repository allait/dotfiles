"use strict";

Cu.import("resource://gre/modules/XPCOMUtils.jsm", modules);

const progressListener = {
    QueryInterface: XPCOMUtils.generateQI([Ci.nsISupportsWeakReference, Ci.nsIWebProgressListener]),

    onSecurityChange: function onSecurityChange(webProgress, request, state) {
        if (state & Ci.nsIWebProgressListener.STATE_IS_INSECURE)
            highlight.set("StatusLine", "");
        else if (state & Ci.nsIWebProgressListener.STATE_IS_BROKEN)
            highlight.set("StatusLine", "color: #f4000f");
        else if (state & Ci.nsIWebProgressListener.STATE_IDENTITY_EV_TOPLEVEL)
            highlight.set("StatusLine", "color: #11c700");
        else if (state & Ci.nsIWebProgressListener.STATE_SECURE_HIGH)
            highlight.set("StatusLine", "color: #3152c7");
    }
};

config.browser.addProgressListener(progressListener, Ci.nsIWebProgress.NOTIFY_SECURITY);
