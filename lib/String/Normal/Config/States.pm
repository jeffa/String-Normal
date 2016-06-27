package String::Normal::Config::States;
use strict;
use warnings;

use String::Normal::Config;

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

#our $to_country = {
#    %{{ map { $_ => 'US' } keys %$us_codes }},
#    %{{ map { $_ => 'CA' } keys %$ca_codes }},
#};

sub _data {
    return {
        us_codes => $us_codes,
        ca_codes => $ca_codes,
        by_short => $by_short,
        by_long  => $by_long,
    };
}

=head1 NAME

String::Normal::Config::States;

=head1 DESCRIPTION

This package defines valid U.S. and Candadian codes.

=cut

1;
