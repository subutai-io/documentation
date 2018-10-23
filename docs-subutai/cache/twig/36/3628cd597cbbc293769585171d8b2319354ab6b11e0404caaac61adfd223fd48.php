<?php

/* partials/search.html.twig */
class __TwigTemplate_d7d261f796de3911f697f6051c58cd2ea30c86dbc33e8fb5dc3468c63fd6d695 extends Twig_Template
{
    public function __construct(Twig_Environment $env)
    {
        parent::__construct($env);

        $this->parent = false;

        $this->blocks = array(
        );
    }

    protected function doDisplay(array $context, array $blocks = array())
    {
        // line 1
        echo "<div class=\"searchbox\">
    <label for=\"search-by\"><i class=\"fa fa-search\"></i></label>
    <input id=\"search-by\" type=\"text\" placeholder=\"";
        // line 3
        echo $this->env->getExtension('Grav\Common\Twig\TwigExtension')->translate("THEME_LEARN2_SEARCH_DOCUMENTATION");
        echo "\"
           data-search-input=\"";
        // line 4
        echo ($context["base_url_relative"] ?? null);
        echo "/search.json/query\"/>
    <span data-search-clear><i class=\"fa fa-close\"></i></span>
</div>
";
    }

    public function getTemplateName()
    {
        return "partials/search.html.twig";
    }

    public function isTraitable()
    {
        return false;
    }

    public function getDebugInfo()
    {
        return array (  27 => 4,  23 => 3,  19 => 1,);
    }

    /** @deprecated since 1.27 (to be removed in 2.0). Use getSourceContext() instead */
    public function getSource()
    {
        @trigger_error('The '.__METHOD__.' method is deprecated since version 1.27 and will be removed in 2.0. Use getSourceContext() instead.', E_USER_DEPRECATED);

        return $this->getSourceContext()->getCode();
    }

    public function getSourceContext()
    {
        return new Twig_Source("", "partials/search.html.twig", "/Users/fernandoted/Sites/documentation/docs-subutai/user/themes/learn2/templates/partials/search.html.twig");
    }
}
