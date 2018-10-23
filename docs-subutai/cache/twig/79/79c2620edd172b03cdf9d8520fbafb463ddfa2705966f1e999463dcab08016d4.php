<?php

/* docs.html.twig */
class __TwigTemplate_9d4c6e014e404184fef88550bc73514f0c693ef17498fcb70d4d93af60df001b extends Twig_Template
{
    public function __construct(Twig_Environment $env)
    {
        parent::__construct($env);

        // line 1
        $this->parent = $this->loadTemplate("partials/base.html.twig", "docs.html.twig", 1);
        $this->blocks = array(
            'navigation' => array($this, 'block_navigation'),
            'content' => array($this, 'block_content'),
        );
    }

    protected function doGetParent(array $context)
    {
        return "partials/base.html.twig";
    }

    protected function doDisplay(array $context, array $blocks = array())
    {
        // line 2
        $context["tags"] = $this->getAttribute($this->getAttribute(($context["page"] ?? null), "taxonomy", array()), "tag", array());
        // line 3
        if (($context["tags"] ?? null)) {
            // line 4
            $context["progress"] = $this->getAttribute(($context["page"] ?? null), "collection", array(0 => array("items" => array("@taxonomy" => array("category" => "docs", "tag" => ($context["tags"] ?? null))), "order" => array("by" => "default", "dir" => "asc"))), "method");
        } else {
            // line 6
            $context["progress"] = $this->getAttribute(($context["page"] ?? null), "collection", array(0 => array("items" => array("@taxonomy" => array("category" => "docs")), "order" => array("by" => "default", "dir" => "asc"))), "method");
        }
        // line 1
        $this->parent->display($context, array_merge($this->blocks, $blocks));
    }

    // line 9
    public function block_navigation($context, array $blocks = array())
    {
        // line 10
        echo "\t<div id=\"navigation\">
\t";
        // line 11
        if ( !$this->getAttribute(($context["progress"] ?? null), "isFirst", array(0 => $this->getAttribute(($context["page"] ?? null), "path", array())), "method")) {
            // line 12
            echo "\t    <a class=\"nav nav-prev\" href=\"";
            echo $this->getAttribute($this->getAttribute(($context["progress"] ?? null), "nextSibling", array(0 => $this->getAttribute(($context["page"] ?? null), "path", array())), "method"), "url", array());
            echo "\"> <i class=\"fa fa-chevron-left\"></i></a>
\t";
        }
        // line 14
        echo "
\t";
        // line 15
        if ( !$this->getAttribute(($context["progress"] ?? null), "isLast", array(0 => $this->getAttribute(($context["page"] ?? null), "path", array())), "method")) {
            // line 16
            echo "\t    <a class=\"nav nav-next\" href=\"";
            echo $this->getAttribute($this->getAttribute(($context["progress"] ?? null), "prevSibling", array(0 => $this->getAttribute(($context["page"] ?? null), "path", array())), "method"), "url", array());
            echo "\"><i class=\"fa fa-chevron-right\"></i></a>
\t";
        }
        // line 18
        echo "\t</div>
";
    }

    // line 21
    public function block_content($context, array $blocks = array())
    {
        // line 22
        echo "    ";
        $this->loadTemplate("partials/page.html.twig", "docs.html.twig", 22)->display($context);
    }

    public function getTemplateName()
    {
        return "docs.html.twig";
    }

    public function isTraitable()
    {
        return false;
    }

    public function getDebugInfo()
    {
        return array (  73 => 22,  70 => 21,  65 => 18,  59 => 16,  57 => 15,  54 => 14,  48 => 12,  46 => 11,  43 => 10,  40 => 9,  36 => 1,  33 => 6,  30 => 4,  28 => 3,  26 => 2,  11 => 1,);
    }

    /** @deprecated since 1.27 (to be removed in 2.0). Use getSourceContext() instead */
    public function getSource()
    {
        @trigger_error('The '.__METHOD__.' method is deprecated since version 1.27 and will be removed in 2.0. Use getSourceContext() instead.', E_USER_DEPRECATED);

        return $this->getSourceContext()->getCode();
    }

    public function getSourceContext()
    {
        return new Twig_Source("", "docs.html.twig", "/Users/fernandoted/Sites/documentation/docs-subutai/user/themes/mytheme/templates/docs.html.twig");
    }
}
