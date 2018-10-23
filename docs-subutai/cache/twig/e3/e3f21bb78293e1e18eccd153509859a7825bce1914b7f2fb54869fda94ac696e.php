<?php

/* partials/base.html.twig */
class __TwigTemplate_dc3a35f4e586865be9839cca414854a324a99e0d556dd63877b71e5f03f01a0a extends Twig_Template
{
    public function __construct(Twig_Environment $env)
    {
        parent::__construct($env);

        $this->parent = false;

        $this->blocks = array(
            'head' => array($this, 'block_head'),
            'stylesheets' => array($this, 'block_stylesheets'),
            'javascripts' => array($this, 'block_javascripts'),
            'sidebar' => array($this, 'block_sidebar'),
            'body' => array($this, 'block_body'),
            'topbar' => array($this, 'block_topbar'),
            'content' => array($this, 'block_content'),
            'footer' => array($this, 'block_footer'),
            'navigation' => array($this, 'block_navigation'),
            'analytics' => array($this, 'block_analytics'),
        );
    }

    protected function doDisplay(array $context, array $blocks = array())
    {
        // line 1
        $context["theme_config"] = $this->getAttribute($this->getAttribute(($context["config"] ?? null), "themes", array()), $this->getAttribute($this->getAttribute($this->getAttribute(($context["config"] ?? null), "system", array()), "pages", array()), "theme", array()));
        // line 2
        $context["github_link_position"] = (((isset($context["github_link_position"]) || array_key_exists("github_link_position", $context))) ? (($context["github_link_position"] ?? null)) : ($this->getAttribute($this->getAttribute(($context["theme_config"] ?? null), "github", array()), "position", array())));
        // line 3
        echo "<!DOCTYPE html>
<html lang=\"";
        // line 4
        echo (($this->getAttribute($this->getAttribute(($context["grav"] ?? null), "language", array()), "getLanguage", array())) ? ($this->getAttribute($this->getAttribute(($context["grav"] ?? null), "language", array()), "getLanguage", array())) : ("en"));
        echo "\">
<head>
    ";
        // line 6
        $this->displayBlock('head', $context, $blocks);
        // line 42
        echo "</head>
<body class=\"searchbox-hidden ";
        // line 43
        echo $this->getAttribute($this->getAttribute(($context["page"] ?? null), "header", array()), "body_classes", array());
        echo "\" data-url=\"";
        echo $this->getAttribute(($context["page"] ?? null), "route", array());
        echo "\">
    ";
        // line 44
        $this->displayBlock('sidebar', $context, $blocks);
        // line 56
        echo "
    ";
        // line 57
        $this->displayBlock('body', $context, $blocks);
        // line 97
        echo "    ";
        $this->displayBlock('analytics', $context, $blocks);
        // line 102
        echo " </body>
</html>
";
    }

    // line 6
    public function block_head($context, array $blocks = array())
    {
        // line 7
        echo "    <meta charset=\"utf-8\" />
    <title>";
        // line 8
        if ($this->getAttribute(($context["header"] ?? null), "title", array())) {
            echo $this->getAttribute(($context["header"] ?? null), "title", array());
            echo " | ";
        }
        echo $this->getAttribute(($context["site"] ?? null), "title", array());
        echo "</title>
    ";
        // line 9
        $this->loadTemplate("partials/metadata.html.twig", "partials/base.html.twig", 9)->display($context);
        // line 10
        echo "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, shrink-to-fit=no\" />
    <link rel=\"alternate\" type=\"application/atom+xml\" href=\"";
        // line 11
        echo ($context["base_url_absolute"] ?? null);
        echo "/feed:atom\" title=\"Atom Feed\" />
    <link rel=\"alternate\" type=\"application/rss+xml\" href=\"";
        // line 12
        echo ($context["base_url_absolute"] ?? null);
        echo "/feed:rss\" title=\"RSS Feed\" />
    <link rel=\"icon\" type=\"image/png\" href=\"";
        // line 13
        echo $this->env->getExtension('Grav\Common\Twig\TwigExtension')->urlFunc("theme://images/favicon.png");
        echo "\">

    ";
        // line 15
        $this->displayBlock('stylesheets', $context, $blocks);
        // line 30
        echo "
    ";
        // line 31
        $this->displayBlock('javascripts', $context, $blocks);
        // line 40
        echo "
    ";
    }

    // line 15
    public function block_stylesheets($context, array $blocks = array())
    {
        // line 16
        echo "        ";
        $this->getAttribute(($context["assets"] ?? null), "addCss", array(0 => "theme://css-compiled/nucleus.css", 1 => 102), "method");
        // line 17
        echo "        ";
        $this->getAttribute(($context["assets"] ?? null), "addCss", array(0 => "theme://css-compiled/theme.css", 1 => 101), "method");
        // line 18
        echo "        ";
        $this->getAttribute(($context["assets"] ?? null), "addCss", array(0 => "theme://css/custom.css", 1 => 100), "method");
        // line 19
        echo "        ";
        $this->getAttribute(($context["assets"] ?? null), "addCss", array(0 => "theme://css/font-awesome.min.css", 1 => 100), "method");
        // line 20
        echo "        ";
        $this->getAttribute(($context["assets"] ?? null), "addCss", array(0 => "theme://css/featherlight.min.css"), "method");
        // line 21
        echo "
        ";
        // line 22
        if (((($this->getAttribute(($context["browser"] ?? null), "getBrowser", array()) == "msie") && ($this->getAttribute(($context["browser"] ?? null), "getVersion", array()) >= 8)) && ($this->getAttribute(($context["browser"] ?? null), "getVersion", array()) <= 9))) {
            // line 23
            echo "            ";
            $this->getAttribute(($context["assets"] ?? null), "addCss", array(0 => "theme://css/nucleus-ie9.css"), "method");
            // line 24
            echo "            ";
            $this->getAttribute(($context["assets"] ?? null), "addCss", array(0 => "theme://css/pure-0.5.0/grids-min.css"), "method");
            // line 25
            echo "            ";
            $this->getAttribute(($context["assets"] ?? null), "addJs", array(0 => "theme://js/html5shiv-printshiv.min.js"), "method");
            // line 26
            echo "        ";
        }
        // line 27
        echo "
        ";
        // line 28
        echo $this->getAttribute(($context["assets"] ?? null), "css", array(), "method");
        echo "
    ";
    }

    // line 31
    public function block_javascripts($context, array $blocks = array())
    {
        // line 32
        echo "        ";
        $this->getAttribute(($context["assets"] ?? null), "addJs", array(0 => "jquery", 1 => 101), "method");
        // line 33
        echo "        ";
        $this->getAttribute(($context["assets"] ?? null), "addJs", array(0 => "theme://js/modernizr.custom.71422.js", 1 => 100), "method");
        // line 34
        echo "        ";
        $this->getAttribute(($context["assets"] ?? null), "addJs", array(0 => "theme://js/featherlight.min.js"), "method");
        // line 35
        echo "        ";
        $this->getAttribute(($context["assets"] ?? null), "addJs", array(0 => "theme://js/clipboard.min.js"), "method");
        // line 36
        echo "        ";
        $this->getAttribute(($context["assets"] ?? null), "addJs", array(0 => "theme://js/jquery.scrollbar.min.js"), "method");
        // line 37
        echo "        ";
        $this->getAttribute(($context["assets"] ?? null), "addJs", array(0 => "theme://js/learn.js"), "method");
        // line 38
        echo "        ";
        echo $this->getAttribute(($context["assets"] ?? null), "js", array(), "method");
        echo "
    ";
    }

    // line 44
    public function block_sidebar($context, array $blocks = array())
    {
        // line 45
        echo "    <nav id=\"sidebar\">
        <div id=\"header-wrapper\">
            <div id=\"header\">
                ";
        // line 49
        echo "                <a id=\"logo\" href=\"";
        echo (($this->getAttribute(($context["theme_config"] ?? null), "home_url", array())) ? ($this->getAttribute(($context["theme_config"] ?? null), "home_url", array())) : (($context["base_url_absolute"] ?? null)));
        echo "\"><img class=\"logoTxt\" src=\"/documentation/docs-subutai/user/themes/mytheme/images/logo-subutai-txt.png\"></a>
                ";
        // line 50
        $this->loadTemplate("partials/search.html.twig", "partials/base.html.twig", 50)->display($context);
        // line 51
        echo "            </div>
        </div>
        ";
        // line 53
        $this->loadTemplate("partials/sidebar.html.twig", "partials/base.html.twig", 53)->display($context);
        // line 54
        echo "    </nav>
    ";
    }

    // line 57
    public function block_body($context, array $blocks = array())
    {
        // line 58
        echo "    <section id=\"body\">
        <div id=\"overlay\"></div>

        <div class=\"padding highlightable\">
            <a href=\"#\" id=\"sidebar-toggle\" data-sidebar-toggle><i class=\"fa fa-2x fa-bars\"></i></a>

            ";
        // line 64
        $this->displayBlock('topbar', $context, $blocks);
        // line 77
        echo "
            ";
        // line 78
        $this->displayBlock('content', $context, $blocks);
        // line 79
        echo "
            ";
        // line 80
        $this->displayBlock('footer', $context, $blocks);
        // line 85
        echo "
        </div>
        ";
        // line 87
        $this->displayBlock('navigation', $context, $blocks);
        // line 95
        echo "    </section>
    ";
    }

    // line 64
    public function block_topbar($context, array $blocks = array())
    {
        if (((($context["github_link_position"] ?? null) == "top") || $this->getAttribute($this->getAttribute($this->getAttribute(($context["config"] ?? null), "plugins", array()), "breadcrumbs", array()), "enabled", array()))) {
            // line 65
            echo "            <div id=\"top-bar\">
                ";
            // line 66
            if ((($context["github_link_position"] ?? null) == "top")) {
                // line 67
                echo "                <div id=\"top-github-link\">
                ";
                // line 68
                $this->loadTemplate("partials/github_link.html.twig", "partials/base.html.twig", 68)->display($context);
                // line 69
                echo "                </div>
                ";
            }
            // line 71
            echo "
                ";
            // line 72
            if ($this->getAttribute($this->getAttribute($this->getAttribute(($context["config"] ?? null), "plugins", array()), "breadcrumbs", array()), "enabled", array())) {
                // line 73
                echo "                ";
                $this->loadTemplate("partials/breadcrumbs.html.twig", "partials/base.html.twig", 73)->display($context);
                // line 74
                echo "                ";
            }
            // line 75
            echo "            </div>
            ";
        }
    }

    // line 78
    public function block_content($context, array $blocks = array())
    {
    }

    // line 80
    public function block_footer($context, array $blocks = array())
    {
        // line 81
        echo "                ";
        if ((($context["github_link_position"] ?? null) == "bottom")) {
            // line 82
            echo "                ";
            $this->loadTemplate("partials/github_note.html.twig", "partials/base.html.twig", 82)->display($context);
            // line 83
            echo "                ";
        }
        // line 84
        echo "            ";
    }

    // line 87
    public function block_navigation($context, array $blocks = array())
    {
        // line 88
        echo "            <a class=\"nav nav-prev\" href=\"/\">
                <i class=\"fa fa-chevron-left\"></i>
            </a>
            <a class=\"nav nav-next\" href=\"/\">
                <i class=\"fa fa-chevron-right\"></i>
            </a>
        ";
    }

    // line 97
    public function block_analytics($context, array $blocks = array())
    {
        // line 98
        echo "        ";
        if ($this->getAttribute(($context["theme_config"] ?? null), "google_analytics_code", array())) {
            // line 99
            echo "        ";
            $this->loadTemplate("partials/analytics.html.twig", "partials/base.html.twig", 99)->display($context);
            // line 100
            echo "        ";
        }
        // line 101
        echo "    ";
    }

    public function getTemplateName()
    {
        return "partials/base.html.twig";
    }

    public function isTraitable()
    {
        return false;
    }

    public function getDebugInfo()
    {
        return array (  325 => 101,  322 => 100,  319 => 99,  316 => 98,  313 => 97,  303 => 88,  300 => 87,  296 => 84,  293 => 83,  290 => 82,  287 => 81,  284 => 80,  279 => 78,  273 => 75,  270 => 74,  267 => 73,  265 => 72,  262 => 71,  258 => 69,  256 => 68,  253 => 67,  251 => 66,  248 => 65,  244 => 64,  239 => 95,  237 => 87,  233 => 85,  231 => 80,  228 => 79,  226 => 78,  223 => 77,  221 => 64,  213 => 58,  210 => 57,  205 => 54,  203 => 53,  199 => 51,  197 => 50,  192 => 49,  187 => 45,  184 => 44,  177 => 38,  174 => 37,  171 => 36,  168 => 35,  165 => 34,  162 => 33,  159 => 32,  156 => 31,  150 => 28,  147 => 27,  144 => 26,  141 => 25,  138 => 24,  135 => 23,  133 => 22,  130 => 21,  127 => 20,  124 => 19,  121 => 18,  118 => 17,  115 => 16,  112 => 15,  107 => 40,  105 => 31,  102 => 30,  100 => 15,  95 => 13,  91 => 12,  87 => 11,  84 => 10,  82 => 9,  74 => 8,  71 => 7,  68 => 6,  62 => 102,  59 => 97,  57 => 57,  54 => 56,  52 => 44,  46 => 43,  43 => 42,  41 => 6,  36 => 4,  33 => 3,  31 => 2,  29 => 1,);
    }

    /** @deprecated since 1.27 (to be removed in 2.0). Use getSourceContext() instead */
    public function getSource()
    {
        @trigger_error('The '.__METHOD__.' method is deprecated since version 1.27 and will be removed in 2.0. Use getSourceContext() instead.', E_USER_DEPRECATED);

        return $this->getSourceContext()->getCode();
    }

    public function getSourceContext()
    {
        return new Twig_Source("", "partials/base.html.twig", "/Users/fernandoted/Sites/documentation/docs-subutai/user/themes/mytheme/templates/partials/base.html.twig");
    }
}
