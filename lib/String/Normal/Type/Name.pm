package String::Normal::Type::Name;
use strict;
use warnings;

=head1 NAME

String::Normal::Type::Name;

=head1 DESCRIPTION

This package defines substitutions to be performed on the name types.

=cut

# Lingua::Stem exceptions
my %exceptions = qw(
@ at
academy acad
academies acad
accent acet
accents acet
accessory acces
accessories acces
account acct
accounts acct
accountant acctnt
accountants acctnt
accounting acctg
administration admin
administrations admin
admiral adm
admirals adm
advertise adv
advertising advg
agency agcy
agencies agcy
alley aly
alleys aly
american amer
americans amer
amount amt
amounts amt
amusement amuse
amusements amuse
antique antq
antiques antq
apartment apt
apartments apt
appliance appl
appliances appl
aquarium aqm
arcade arcd
arcades arcd
architect archt
architects archt
assistant asst
assistants asst
associate assoc
associates assoc
association assn
associations assn
attny atty
attorney atty
attorneys atty
auction auctn
auctions auctn
auctioneer auctnr
auctioneers auctnr
authority auth
authorities auth
authorized authzd
automatic automtc
automobile auto
automobiles auto
automotive automtv
automotives automtv
baptist bapt
baptists bapt
barbeque bbq
barbeques bbq
barbque bbq
beach bch
beaches bch
bluff blf
bluffs blf
bookkeeping bkpg
boutique btq
boutiques btq
branch br
branches br
brother bro
brothers bro
building bldg
buildings bldg
bureau bur
bureaus bur
burg bg
burgs bg
business bus
businesses bus
cabinet cabnt
cabinets cabnt
cadillac cad
cadillacs cad
caffe cafe
caffes cafe
camera cam
cameras cam
canyon cyn
canyons cyn
cape cpe
capes cpe
center ctr
centers ctr
ceramic crmc
cermc crmc
certified cert
chemical chem
chemicals chem
chevrolet chev
children child
childrn child
chiropractic chiro
church chr
churches chr
cliff clf
cliffs clf
college clg
colleges clg
commercial coml
commercials coml
commission commn
commissions commn
communication comm
communications comm
community cmnty
company co
companies co
compressor comprsr
compressors comprsr
condition cond
conditions cond
condominium condo
condominiums condo
congregation congrgtn
congregations congrgtn
consolidated cons
construction constr
constructions constr
consultant conslnt
consultants conslnt
consulting consltng
consultings consltng
container contnr
containers contnr
continental contl
continentals contl
continued contd
contracting contrng
contractings contrng
contractor contr
contractors contr
conversion convrsn
conversions convrsn
cooperative coop
cooperatives coop
corner cor
corners cor
corporation corp
corporations corp
course crse
courses crse
court ct
courts ct
custom cstm
customs cstm
delicatessen deli
delicatessens deli
dep dept
department dept
departments dept
departmnt dept
developer devlpr
developers devlpr
development devmnt
developments devmnt
discount disc
discounts disc
dismantler dismtlr
dismantlers dismtlr
dispensary dispense
dispensaries dispense
disposal dispose
disposals dispose
distributor distr
distributors distr
district dist
districts dist
division div
divisions div
do dr
doctor dr
doctors dr
doughnut donut
doughnuts donut
drgst drug
drive dr
druggist drug
east e
electric elctrc
electrics elctrc
electrical elecl
electronics elctro
employee empl
employees empl
emporium empr
emporiums empr
engine eng
engines eng
engineer engr
engineers engr
engraving engrv
engravings engrv
ent entrprs
enterprise entrprs
enterprises ent
entertainment entrtn
entertainments entrtn
entrmt entrtn
equip eqpt
equipment eqpt
estate est
estates est
excavating excavtg
exchange exch
exchanges exch
express exp
fabrication fab
fabrications fab
fall fl
falls fl
fdrl fed
federal fed
fedl fed
fedrl fed
ferry fry
fertilizer fert
fertilizers fert
financial fncl
fitness fitns
forwarder frwrdrs
forwarders frwrdrs
freight frt
frtlzr fert
furnishings furnsng
furniture furn
garage grge
garages grge
garden gdn
gardens gdn
general gen
generals gen
generator genrtr
generators genrtr
genl gen
gentlemen gent
grain grn
grains grn
grocery groc
groceries groc
ground grnd
grounds grnd
handicapped hndcpd
harbor hbr
harbors hbr
hardware hdwr
hardwares hdwr
hdq hq
hdqrs hq
hdqs hq
headquarter hq
headquarters hq
heating htg
heavy hvy
heavies hvy
heights ht
highland hgld
highlands hgld
hill hl
hills hl
home hm
homes hm
hospital hosp
hospitals hosp
house hse
housees hse
hqts hq
hudson hdsn
ii 2
iii 3
implement impl
impress imprsn
impression imprsn
impressions imprsn
improvement imprvmt
improvements imprvmt
incorporated inc
industrial indl
industry ind
industries ind
information info
installation instltn
installations instltn
institute inst
institutes inst
institution instn
institutional instnl
institutions instn
instrument instr
instruments instr
insurance ins
insurances ins
intercontinental intercontl
international intl
interstate i
interstates i
irrigation irrgtn
isl is
island is
islands is
iv 4
ix 9
junction jct
junctions jct
kennel knnl
kennels knnl
knoll knl
knolls knl
laboratory lab
laboratories lab
landscaping landscpg
lawnmower lawnmwr
lawnmowers lawnmwr
limited ltd
lithograph lithogph
lithographs lithogph
lithographer lithogphr
lithographers lithogphr
lithographing lithogphng
lrtng letter
lubricant lubcnt
lubricants lubcnt
lubrication lub
lubrications lub
lumber lbr
lutheran luth
lutherans luth
machine mach
machines mach
machinery machry
machineries machry
maintenance mntnc
maintenances mntnc
management mgmt
managements mgmt
manager mgr
managers mgr
manufactured mfd
manufacturer mfr
manufacturers mfr
manufacturing mfg
marine mrne
market mkt
markets mkt
marketing mktg
masonry mason
md dr
mechanic mech
mechanical mechcl
medical medcl
memorial meml
memorials meml
mercantile merctl
mercantiles merctl
merchandise mdse
mercury merc
methodist mthdst
mill ml
mills ml
millwork millwk
mission msn
missions msn
mortgage mtg
mortgages mtg
mount mt
mounts mt
mountain mt
mountains mt
mtn mt
muni mun
municipal mncpl
municipals mncpl
museum mus
museums mus
mutual mutl
national natl
nationals natl
natural natrl
naturals natrl
north n
northeast ne
northwest nw
number no
numbers no
nursery nrsy
nurseries nrsy
nursing nurse
nutrition nutri
office ofc
offices ofc
oldsmobile olds
optical optl
optician opt
opticians opt
organization org
organizations org
orthopedic ortho
package pkg
packages pkg
packaging pkgng
packagings pkgng
partner prtnr
partners prtnr
pathology path
petroleum petro
pharmacy pharm
pharmacies pharm
phd dr
phrmcy pharm
physician phy
physicians phy
pickup pkup
plain pln
plains pln
plumbing plbg
printer print
printers print
printing ptg
private pvt
processing procng
processor proc
processors proc
product prod
products prod
professional pro
professionals pro
protection protctn
psychiatric psych
public pubc
publication publ
publications publ
publisher pubh
publishers pubh
publishing pubg
radiator radtr
radiators radtr
reconditioning recond
recreation rec
refining refng
refrigeration refrign
refrigerator refrig
refrigerators refrig
regional regl
rehabilitation rehab
remodeling remod
removal remvl
rental rent
rentals rent
resort resrt
resorts resrt
restaurant rstrnt
restaurants rstrnt
retirement retire
rmdlg remod
rnt rent
rntl rent
rubber rbr
rubbers rbr
rubbish rbsh
saint st
saints st
san sn
sanitation sani
science sci
sciences sci
sec second
secretarial sectrl
securities sec
service svc
servicenter svctr
services svc
sharpening sharp
shoal shl
shoals shl
shopping shpg
shore shr
shores shr
showroom showrm
showrooms showrm
small sm
south s
southeast se
southwest sw
specialist speclst
specialists speclst
specialties spec
specialty spec
spring spg
springs spg
standard std
standards std
station sta
stations sta
stationery statnry
storage stge
storages stge
supercenter suprctr
supercenters suprctr
supermarket sprmkt
supermarkets sprmkt
supl suply
supplement suplmt
supplements suplmt
supplier suplr
supplies supl
suppliers suplr
supply supl
supplys supl
surgery surg
surgical surgcl
sweeping swpg
system syst
systems syst
technology tech
telephone phone
telephones phone
television tv
televisions tv
townhouse twnhse
townhouses twnhse
township twp
townships twp
transcontinental transcontl
transmission trans
transmissions trans
transportation trnsprtn
transportations trnsprtn
trophy troph
trophies troph
tropical trop
tropicals trop
tunnel tunl
tunnels tunl
tuxedo tux
tuxedoes tux
universal univrsl
universities univ
university univ
unlimited unltd
vacation vac
vacations vac
valley vly
valleys vly
veterinarian vet
veterinarians vet
veterinary vetry
veterinaries vetry
vii 7
viii 8
village vlg
villages vlg
volkswagen vw
wallpaper wlpaper
warehouse wrhse
warehouses wrhse
wedding wedd
weddings wedd
west w
wharf whf
wharves whf
wholesale whls
wholesaler whlsr
wholesalers whlsr
woodworking woodwkg
wrecking wrckg
yard yd
yards yd
);

# the pound sign is always troublesome in perl
$exceptions{'#'} = 'no';

my %deletions = (
    de           => '',
    da           => '',
    du           => '',
    'le'         => '',
    'and'        => '',
    the          => '',
    of           => '',
    from         => '',
    inc          => '',
    incorporated => '',
);

my %hashmap = ( %exceptions, %deletions );

# Export the variable $hashmap as a reference to the hash
our $hashmap = \%hashmap;

1;
