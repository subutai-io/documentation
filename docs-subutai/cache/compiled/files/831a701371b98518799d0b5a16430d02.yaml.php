<?php
return [
    '@class' => 'Grav\\Common\\File\\CompiledYamlFile',
    'filename' => '/Users/fernandoted/Sites/documentation/docs-subutai/user/config/plugins/admin.yaml',
    'modified' => 1540301231,
    'data' => [
        'enabled' => true,
        'route' => '/admin',
        'cache_enabled' => false,
        'theme' => 'grav',
        'content_padding' => true,
        'twofa_enabled' => true,
        'sidebar' => [
            'activate' => 'tab',
            'hover_delay' => 100,
            'size' => 'auto'
        ],
        'dashboard' => [
            'days_of_stats' => 7
        ],
        'widgets' => [
            'dashboard-maintenance' => true,
            'dashboard-statistics' => true,
            'dashboard-notifications' => true,
            'dashboard-feed' => true,
            'dashboard-pages' => true
        ],
        'pages' => [
            'show_parents' => 'both'
        ],
        'session' => [
            'timeout' => 1800
        ],
        'warnings' => [
            'delete_page' => true
        ],
        'edit_mode' => 'normal',
        'frontend_pages_target' => '_blank',
        'show_github_msg' => true,
        'pages_list_display_field' => 'title',
        'google_fonts' => true,
        'admin_icons' => 'font-awesome',
        'enable_auto_updates_check' => false,
        'notifications' => [
            'feed' => true,
            'dashboard' => true,
            'plugins' => true,
            'themes' => true
        ],
        'popularity' => [
            'enabled' => true,
            'ignore' => [
                0 => '/test*',
                1 => '/modular'
            ],
            'history' => [
                'daily' => '30',
                'monthly' => '12',
                'visitors' => '20'
            ]
        ],
        'add_modals' => [
            0 => [
                'label' => 'Add Chapter',
                'blueprint' => 'admin/pages/new_chapter',
                'show_in' => 'bar'
            ],
            1 => [
                'label' => 'Add Documentation Page',
                'blueprint' => 'admin/pages/new_docs_page',
                'show_in' => 'bar'
            ]
        ],
        'hide_page_types' => [
            0 => 'feed'
        ]
    ]
];
