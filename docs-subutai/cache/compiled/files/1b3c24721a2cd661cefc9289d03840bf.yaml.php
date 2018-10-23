<?php
return [
    '@class' => 'Grav\\Common\\File\\CompiledYamlFile',
    'filename' => '/Users/fernandoted/Sites/documentation/docs-subutai/user/plugins/jscomments/jscomments.yaml',
    'modified' => 1540301232,
    'data' => [
        'enabled' => true,
        'active' => true,
        'provider' => '',
        'providers' => [
            'discourse' => [
                'host' => ''
            ],
            'disqus' => [
                'shortname' => '',
                'show_count' => false,
                'language' => ''
            ],
            'facebook' => [
                'app_id' => '',
                'num_posts' => 5,
                'colorscheme' => 'light',
                'order_by' => 'social',
                'language' => '',
                'width' => '100%'
            ],
            'googleplus' => [
                'show_count' => false,
                'language' => '',
                'width' => '100%'
            ],
            'intensedebate' => [
                'account_number' => ''
            ],
            'isso' => [
                'host' => '',
                'builtin_css' => true,
                'language' => '',
                'reply_to_self' => false,
                'require' => [
                    'author' => true,
                    'email' => true
                ],
                'comments' => [
                    'number' => 10,
                    'nested_number' => 5,
                    'reveal' => 5
                ],
                'avatar' => [
                    'enabled' => true,
                    'background' => '',
                    'foreground' => ''
                ],
                'vote' => [
                    'enabled' => true,
                    'levels' => '-5,5'
                ]
            ],
            'muut' => [
                'forum' => '',
                'channel' => 'General',
                'widget' => false,
                'show_online' => false,
                'show_title' => false,
                'upload' => false,
                'share' => true,
                'language' => ''
            ],
            'hypercomments' => [
                'widget_id' => NULL,
                'social' => [
                    0 => 'vk',
                    1 => 'odnoklassniki',
                    2 => 'yandex',
                    3 => 'mailru',
                    4 => 'google',
                    5 => 'livejournal',
                    6 => 'facebook',
                    7 => 'twitter',
                    8 => 'tumblr'
                ]
            ]
        ]
    ]
];
