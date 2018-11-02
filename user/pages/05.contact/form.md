---
title: Contact
template: contact-form
form:
    name: contact
    classes: contactForm

    fields:
        - name: name
          label: Name
        #   placeholder: Enter your name
          autocomplete: on
          type: text
          validate:
            required: true

        - name: email
          label: E-mail address
        #   placeholder: Enter your email address
          type: email
          validate:
            required: true

        - name: message
          label: Message
        #   placeholder: Enter your message
          type: textarea
          validate:
            required: true

        - name: g-recaptcha-response
          label: Captcha
          type: captcha
          outerclasses: captcha-wrap
          recaptcha_site_key: 6LcJT28UAAAAADLY9bSELTiLl3-nuYWiEa-kVTXS
          recaptcha_not_validated: 'Captcha not valid!'
          validate:
            required: true

    buttons:
        - type: submit
          value: Submit
        # - type: reset
        #   value: Reset

    process:
        - captcha:
            recaptcha_secret: 6LcJT28UAAAAANbpkOekMI6CykQkGtYXMELKPdfX
        - email:
            from: "{{ config.plugins.email.from }}"
            to:
              - "{{ config.plugins.email.from }}"
              # - "{{ form.value.email }}"
            subject: "[Site Contact Form] {{ form.value.name|e }}"
            body: "{% include 'forms/data.html.twig' %}"
        - save:
            fileprefix: contact-
            dateformat: Ymd-His-u
            extension: txt
            body: "{% include 'forms/data.txt.twig' %}"
        # - message: Thank you for getting in touch!
        - display: thankyou
---

<div class="headline" markdown="1">
  <div class="colFull">
    <h2 class="titleSection marginBottom-zero">Careers</h2>
  </div>
</div>

<p style="padding-top: 0;">We're always on the lookout for great talent. We’re quickly growing our distributed team, and are hiring front-end, UI/UX, and Web design developers, as well as other posts. If interested, please send us a cover letter and your CV to info@optdyn.com.</p>
