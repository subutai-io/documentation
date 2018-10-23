<?php

/* partials/sidebar.html.twig */
class __TwigTemplate_2a345cc21b95628e8abf328cc66a92cc83192e47443c2fb051e84a33f823b36e extends Twig_Template
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
        // line 23
        echo "
";
        // line 36
        echo "
<div class=\"scrollbar-inner\">
    <div class=\"highlightable\">
        ";
        // line 39
        if ($this->getAttribute(($context["theme_config"] ?? null), "top_level_version", array())) {
            // line 40
            echo "            ";
            $context['_parent'] = $context;
            $context['_seq'] = twig_ensure_traversable($this->getAttribute(($context["pages"] ?? null), "children", array()));
            foreach ($context['_seq'] as $context["slug"] => $context["ver"]) {
                // line 41
                echo "                ";
                echo $this->getAttribute($this, "version", array(0 => $context["ver"]), "method");
                echo "
                <ul id=\"";
                // line 42
                echo $context["slug"];
                echo "\" class=\"topics\">
                ";
                // line 43
                echo $this->getAttribute($this, "loop", array(0 => $context["ver"], 1 => ""), "method");
                echo "
                </ul>
            ";
            }
            $_parent = $context['_parent'];
            unset($context['_seq'], $context['_iterated'], $context['slug'], $context['ver'], $context['_parent'], $context['loop']);
            $context = array_intersect_key($context, $_parent) + $_parent;
            // line 46
            echo "        ";
        } else {
            // line 47
            echo "            <ul class=\"topics\">
                ";
            // line 48
            if ($this->getAttribute(($context["theme_config"] ?? null), "root_page", array())) {
                // line 49
                echo "                    ";
                echo $this->getAttribute($this, "loop", array(0 => $this->getAttribute(($context["page"] ?? null), "find", array(0 => $this->getAttribute(($context["theme_config"] ?? null), "root_page", array())), "method"), 1 => ""), "method");
                echo "
                ";
            } else {
                // line 51
                echo "            ";
                echo $this->getAttribute($this, "loop", array(0 => ($context["pages"] ?? null), 1 => ""), "method");
                echo "
                ";
            }
            // line 53
            echo "            </ul>
        ";
        }
        // line 55
        echo "        <hr />

        <a class=\"padding\" href=\"#\" data-clear-history-toggle><i
                    class=\"fa fa-fw fa-history\"></i> ";
        // line 58
        echo $this->env->getExtension('Grav\Common\Twig\TwigExtension')->translate("THEME_LEARN2_CLEAR_HISTORY");
        echo "</a><br/>

        <section id=\"footer\">
            ";
        // line 62
        echo "            <p>Developed by <a href=\"#\">OptDyn</a></p>
        </section>
    </div>
</div>
";
    }

    // line 1
    public function getloop($__page__ = null, $__parent_loop__ = null, ...$__varargs__)
    {
        $context = $this->env->mergeGlobals(array(
            "page" => $__page__,
            "parent_loop" => $__parent_loop__,
            "varargs" => $__varargs__,
        ));

        $blocks = array();

        ob_start();
        try {
            // line 2
            echo "    ";
            if ((twig_length_filter($this->env, ($context["parent_loop"] ?? null)) > 0)) {
                // line 3
                echo "        ";
                $context["data_level"] = ($context["parent_loop"] ?? null);
                // line 4
                echo "    ";
            } else {
                // line 5
                echo "        ";
                $context["data_level"] = 0;
                // line 6
                echo "    ";
            }
            // line 7
            echo "    ";
            $context['_parent'] = $context;
            $context['_seq'] = twig_ensure_traversable($this->getAttribute($this->getAttribute(($context["page"] ?? null), "children", array()), "visible", array()));
            $context['loop'] = array(
              'parent' => $context['_parent'],
              'index0' => 0,
              'index'  => 1,
              'first'  => true,
            );
            if (is_array($context['_seq']) || (is_object($context['_seq']) && $context['_seq'] instanceof Countable)) {
                $length = count($context['_seq']);
                $context['loop']['revindex0'] = $length - 1;
                $context['loop']['revindex'] = $length;
                $context['loop']['length'] = $length;
                $context['loop']['last'] = 1 === $length;
            }
            foreach ($context['_seq'] as $context["_key"] => $context["p"]) {
                // line 8
                echo "        ";
                $context["parent_page"] = (($this->getAttribute($context["p"], "activeChild", array())) ? (" parent") : (""));
                // line 9
                echo "        ";
                $context["current_page"] = (($this->getAttribute($context["p"], "active", array())) ? (" active") : (""));
                // line 10
                echo "        <li class=\"dd-item";
                echo ($context["parent_page"] ?? null);
                echo ($context["current_page"] ?? null);
                echo "\" data-nav-id=\"";
                echo $this->getAttribute($context["p"], "route", array());
                echo "\">
            <a href=\"";
                // line 11
                echo $this->getAttribute($context["p"], "url", array());
                echo "\" ";
                if ($this->getAttribute($this->getAttribute($context["p"], "header", array()), "class", array())) {
                    echo "class=\"";
                    echo $this->getAttribute($this->getAttribute($context["p"], "header", array()), "class", array());
                    echo "\"";
                }
                echo ">
                <i class=\"fa fa-check read-icon\"></i>
                <span><b>";
                // line 13
                if ((($context["data_level"] ?? null) == 0)) {
                    echo $this->getAttribute($context["loop"], "index", array());
                    echo ". ";
                }
                echo "</b>";
                echo $this->getAttribute($context["p"], "menu", array());
                echo "</span>
            </a>
            ";
                // line 15
                if (($this->getAttribute($this->getAttribute($context["p"], "children", array()), "count", array()) > 0)) {
                    // line 16
                    echo "            <ul>
                ";
                    // line 17
                    echo $this->getAttribute($this, "loop", array(0 => $context["p"], 1 => ((((isset($context["parent_loop"]) || array_key_exists("parent_loop", $context))) ? (_twig_default_filter(($context["parent_loop"] ?? null), 0)) : (0)) + $this->getAttribute($context["loop"], "index", array()))), "method");
                    echo "
            </ul>
            ";
                }
                // line 20
                echo "        </li>
    ";
                ++$context['loop']['index0'];
                ++$context['loop']['index'];
                $context['loop']['first'] = false;
                if (isset($context['loop']['length'])) {
                    --$context['loop']['revindex0'];
                    --$context['loop']['revindex'];
                    $context['loop']['last'] = 0 === $context['loop']['revindex0'];
                }
            }
            $_parent = $context['_parent'];
            unset($context['_seq'], $context['_iterated'], $context['_key'], $context['p'], $context['_parent'], $context['loop']);
            $context = array_intersect_key($context, $_parent) + $_parent;
        } catch (Exception $e) {
            ob_end_clean();

            throw $e;
        } catch (Throwable $e) {
            ob_end_clean();

            throw $e;
        }

        return ('' === $tmp = ob_get_clean()) ? '' : new Twig_Markup($tmp, $this->env->getCharset());
    }

    // line 24
    public function getversion($__p__ = null, ...$__varargs__)
    {
        $context = $this->env->mergeGlobals(array(
            "p" => $__p__,
            "varargs" => $__varargs__,
        ));

        $blocks = array();

        ob_start();
        try {
            // line 25
            echo "    ";
            $context["parent_page"] = (($this->getAttribute(($context["p"] ?? null), "activeChild", array())) ? (" parent") : (""));
            // line 26
            echo "    ";
            $context["current_page"] = (($this->getAttribute(($context["p"] ?? null), "active", array())) ? (" active") : (""));
            // line 27
            echo "    <h5 class=\"";
            echo ($context["parent_page"] ?? null);
            echo ($context["current_page"] ?? null);
            echo "\">
        ";
            // line 28
            if (($this->getAttribute(($context["p"] ?? null), "activeChild", array()) || $this->getAttribute(($context["p"] ?? null), "active", array()))) {
                // line 29
                echo "        <i class=\"fa fa-chevron-down fa-fw\"></i>
        ";
            } else {
                // line 31
                echo "        <i class=\"fa fa-plus fa-fw\"></i>
        ";
            }
            // line 33
            echo "        <a href=\"";
            echo $this->getAttribute(($context["p"] ?? null), "url", array());
            echo "\">";
            echo $this->getAttribute(($context["p"] ?? null), "menu", array());
            echo "</a>
    </h5>
";
        } catch (Exception $e) {
            ob_end_clean();

            throw $e;
        } catch (Throwable $e) {
            ob_end_clean();

            throw $e;
        }

        return ('' === $tmp = ob_get_clean()) ? '' : new Twig_Markup($tmp, $this->env->getCharset());
    }

    public function getTemplateName()
    {
        return "partials/sidebar.html.twig";
    }

    public function isTraitable()
    {
        return false;
    }

    public function getDebugInfo()
    {
        return array (  249 => 33,  245 => 31,  241 => 29,  239 => 28,  233 => 27,  230 => 26,  227 => 25,  215 => 24,  187 => 20,  181 => 17,  178 => 16,  176 => 15,  166 => 13,  155 => 11,  147 => 10,  144 => 9,  141 => 8,  123 => 7,  120 => 6,  117 => 5,  114 => 4,  111 => 3,  108 => 2,  95 => 1,  87 => 62,  81 => 58,  76 => 55,  72 => 53,  66 => 51,  60 => 49,  58 => 48,  55 => 47,  52 => 46,  43 => 43,  39 => 42,  34 => 41,  29 => 40,  27 => 39,  22 => 36,  19 => 23,);
    }

    /** @deprecated since 1.27 (to be removed in 2.0). Use getSourceContext() instead */
    public function getSource()
    {
        @trigger_error('The '.__METHOD__.' method is deprecated since version 1.27 and will be removed in 2.0. Use getSourceContext() instead.', E_USER_DEPRECATED);

        return $this->getSourceContext()->getCode();
    }

    public function getSourceContext()
    {
        return new Twig_Source("", "partials/sidebar.html.twig", "/Users/fernandoted/Sites/documentation/docs-subutai/user/themes/mytheme/templates/partials/sidebar.html.twig");
    }
}
