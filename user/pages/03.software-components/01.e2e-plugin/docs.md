---
title: 'Using the E2E Plugin'
visible: true
taxonomy:
    category:
        - docs
---

Using the E2E Plugin
In Bazaar, when asked to set up a PGP key, you may set up one manually or use the E2E browser plugin. The plugin helps you generate PGP keys, manage them, and keep them secure. For more information about the plugin, see [E2E Plugin](https://docs.subutai.io/Products/Bazaar/27_E2E_plugin.html).

### How to install the E2E Plugin

To install the E2E browser plugin:

1. Download and add the E2E plugin for your browser through the links below:
   * [Firefox](https://addons.mozilla.org/en-US/firefox/addon/subutai-e2e-plugin/)
   * [Chrome](https://chrome.google.com/webstore/detail/subutai-e2e-plugin/ffddnlbamkjlbngpekmdpnoccckapcnh)
   * For other supported browsers, go to [https://github.com/subutai-io/browser-plugins/releases](https://github.com/subutai-io/browser-plugins/releases). From a particular browser's page, you may search for instructions on installing plugins or extensions.

    After adding the plugin, you will be prompted to generate the key.  

2. On the Generate key popup, enter your email address, and then click **Generate**.   

   ![E2E plugin](e2e-generate-key.png)
 
3. On the plugin page, click the  icon to access the key.   

4. In the Fingerprint field of the Main key tab, copy the entire key.

   ✔️ If you are not logged in to Subutai Bazaar, you can do so now to set up the key.
   
   ![Upload key](e2e-upload-key.png)

5. On the Bazaar page, click your account name located at the upper right corner.   

   This displays the Account settings popup.    

   💡 If you have the Set PGP key message displayed, click the link to access Account settings. 

6. On Account settings, paste the PGP key in the PGP Key fingerprint field, and then click **Upload**.   

   The Owner PGP Key field is populated automatically. You must not edit or modify this field.   

7. Click **Save**.    

   💡 If you encounter an error when entering or saving this key, you can delete it from the plugin page, and then generate a new key. You only need one PGP key for your Bazaar account.
