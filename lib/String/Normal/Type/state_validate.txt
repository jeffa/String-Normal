package String::Normal::Type::State;
use strict;
use warnings;

=head1 NAME

String::Normal::Type::State;

=head1 DESCRIPTION

This package defines substitutions to be performed on state types.

=cut
our $us_codes = {
    ak => 'alaska',
    al => 'alabama',
    ar => 'arkansas',
    as => 'american samoa',
    az => 'arizona',
    ca => 'california',
    co => 'colorado',
    ct => 'connecticut',
    dc => 'district of columbia',
    de => 'delaware',
    fl => 'florida',
    fm => 'federated states of micronesia',
    ga => 'georgia',
    gu => 'guam',
    hi => 'hawaii',
    ia => 'iowa',
    id => 'idaho',
    il => 'illinois',
    in => 'indiana',
    ks => 'kansas',
    ky => 'kentucky',
    la => 'louisiana',
    ma => 'massachusetts',
    md => 'maryland',
    me => 'maine',
    mh => 'marshall islands',
    mi => 'michigan',
    mn => 'minnesota',
    mo => 'missouri',
    mp => 'northern mariana islands',
    ms => 'mississippi',
    mt => 'montana',
    nc => 'north carolina',
    nd => 'north dakota',
    ne => 'nebraska',
    nh => 'new hampshire',
    nj => 'new jersey',
    nm => 'new mexico',
    nv => 'nevada',
    ny => 'new york',
    oh => 'ohio',
    ok => 'oklahoma',
    or => 'oregon',
    pa => 'pennsylvania',
    pr => 'puerto rico',
    pw => 'palau',
    ri => 'rhode island',
    sc => 'south carolina',
    sd => 'south dakota',
    tn => 'tennessee',
    tx => 'texas',
    ut => 'utah',
    va => 'virginia',
    vi => 'virgin islands',
    vt => 'vermont',
    wa => 'washington',
    wi => 'wisconsin',
    wv => 'west virginia',
    wy => 'wyoming',
};

our $ca_codes = {
    ab => 'alberta',
    bc => 'british columbia',
    mb => 'manitoba',
    nb => 'new brunswick',
    nl => 'newfoundland and labrador',
    ns => 'nova scotia',
    nt => 'northwest territories',
    nu => 'nunavut',
    on => 'ontario',
    pe => 'prince edward island',
    qc => 'quebec',
    sk => 'saskatchewan',
    yt => 'yukon territory',
};

our $by_short = { %$us_codes, %$ca_codes };
our $by_long  = { reverse %$by_short };

our $to_country = {
    %{{ map { $_ => 'US' } keys %$us_codes }},
    %{{ map { $_ => 'CA' } keys %$ca_codes }},
};

1;
