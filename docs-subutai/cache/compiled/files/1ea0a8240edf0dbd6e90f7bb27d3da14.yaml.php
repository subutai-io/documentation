<?php
return [
    '@class' => 'Grav\\Common\\File\\CompiledYamlFile',
    'filename' => 'themes://mytheme/mytheme.yaml',
    'modified' => 1532554914,
    'data' => [
        'enabled' => true,
        'root_page' => NULL,
        'top_level_version' => false,
        'google_analytics_code' => NULL,
        'home_url' => NULL,
        'github' => [
            'position' => 'top',
            'icon' => NULL,
            'tree' => NULL
        ],
        'streams' => [
            'schemes' => [
                'theme' => [
                    'type' => 'ReadOnlyStream',
                    'prefixes' => [
                        '' => [
                            0 => 'user/themes/mytheme',
                            1 => 'user/themes/learn2-git-sync',
                            2 => 'user/themes/learn2'
                        ]
                    ]
                ]
            ]
        ]
    ]
];
