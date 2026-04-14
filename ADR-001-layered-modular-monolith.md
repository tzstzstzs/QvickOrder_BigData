# ADR-001: Layered Architecture + Modular Monolith választása a QuickOrder rendszerhez

## Státusz

Accepted

## Dátum

2026-04-14

## Kontextus

- A QuickOrder egy online rendeléskezelő platform kis éttermek és street food vállalkozások számára.
- A rendszer célja, hogy egységes digitális megoldást adjon étteremlistázásra, menüböngészésre, kosárkezelésre, rendelésleadásra, online fizetésre, rendelési státuszkövetésre, valamint éttermi adminisztrációra.
- A várható induló méret körülbelül `10 000` felhasználó és `100` étterem.
- A kiinduló üzleti elvárás gyors piacra lépés, egyszerű megvalósíthatóság és költséghatékony fejlesztés.
- A fontos nem funkcionális elvárások: gyors válaszidő, kezelhető növekedés, egyszerű telepítés, jó karbantarthatóság, megfelelő rendelkezésre állás, adatintegritás, külső integrációs kompatibilitás.
- A meglévő modell alapján a rendszer több kliensfelületet szolgál ki: `Web Application` és `Mobile Application`.
- A külső integrációk a DSL szerint: `External Payment Provider` és `Notification Service`.
- A jelenlegi architektúramodell egyetlen `Application Backend` konténert mutat, amely belül API, application service, domain, integration adapter és repository elemekre bontott.
- Ez azt jelzi, hogy a projektben már nem egy elméleti döntésről, hanem egy ténylegesen kiválasztott és modellezett architektúráról van szó.

## Döntés

- A QuickOrder rendszerhez a választott architektúra:
  - `Layered Architecture`
  - `Modular Monolith`
- A döntés lényege, hogy a rendszer backendje egyetlen deployolható egységként működik, de azon belül világos rétegek és funkcionális modulok különülnek el.
- A réteges felosztás a meglévő modellben az alábbi módon jelenik meg:
  - API réteg: `Catalog API`, `Order API`, `Admin API`
  - alkalmazási réteg: `Cart Application Service`, `Order Application Service`, `Payment Application Service`, `Restaurant Admin Application Service`
  - domain réteg: `Catalog Domain Module`, `Cart Domain Module`, `Order Domain Module`
  - integrációs réteg: `Payment Integration Adapter`, `Notification Integration Adapter`
  - perzisztencia réteg: `Repository Layer`
- A moduláris monolit megközelítés azt jelenti, hogy ezek a felelősségek egy közös backend konténeren belül helyezkednek el, nem külön szolgáltatásokként.

## Indoklás

- A választás jól illeszkedik a projekt jelenlegi üzleti és technikai helyzetéhez.
- A gyors indulás és a költséghatékonyság miatt nem indokolt az elején egy összetett, sok szolgáltatásból álló architektúra.
- A `responsiveness` szempontjából előnyös, hogy a backend belső együttműködése folyamaton belüli hívásokkal történik, nem hálózati mikroszerviz-kommunikációval.
- Ez csökkenti a kommunikációs overheadet, egyszerűsíti a hibakezelést, és segíti a gyors válaszidőt a rendelési folyamatokban.
- A `scalability` szempontjából a várható induló méret mellett egy moduláris monolit elegendő és racionális kiindulópont.
- A rendszer később horizontálisan skálázható alkalmazásszinten, miközben a belső modulhatárok megőrzik a későbbi szétválasztás lehetőségét.
- A `deployability` szempontjából egyszerűbb egyetlen backend konténert buildelni, tesztelni és telepíteni, mint több egymástól függő mikroszervizt.
- Ez különösen fontos olyan projektkörnyezetben, ahol az egyszerűség és a gyors szállítás kiemelt szempont.
- A `maintainability` szempontjából a réteges szerkezet világos felelősségi határokat ad.
- A meglévő DSL-ben jól látható, hogy a vezérlők, az alkalmazási szolgáltatások, a domain logika, az integrációs adapterek és a repository réteg elkülönülnek.
- Ez javítja az átláthatóságot, segíti a tesztelést, és csökkenti annak kockázatát, hogy az üzleti logika szétszóródjon a rendszerben.
- Az `availability` szempontjából a kisebb operációs komplexitás előnyös.
- Kevesebb különálló szolgáltatás kevesebb hálózati hibahelyet, egyszerűbb monitorozást és egyszerűbb üzemeltetést jelent.
- A `data integrity` a QuickOrder esetében különösen fontos, mert rendelések, kosarak és fizetési folyamatok kezeléséről van szó.
- Egy egységes backend és központi adatkezelés mellett egyszerűbb az üzleti szabályok konzisztens érvényesítése és a tranzakciós szemlélet fenntartása.
- A `feasibility` szempontjából a moduláris monolit kedvezőbb költségben és megvalósítási időben.
- Nem igényel az induláskor olyan szintű infrastruktúrát, DevOps-érettséget és operációs felkészültséget, mint egy mikroszerviz-architektúra.
- A mikroszervizes alternatíva ebben a szakaszban azért nem kedvezőbb, mert a projekt mérete és az induló terhelés még nem indokolja a szolgáltatásokra bontásból fakadó többletbonyolultságot.
- Mikroszervizek esetén nőne a hálózati kommunikáció, a verziókezelési függés, a monitorozási igény, a hibakeresési nehézség és az üzemeltetési költség.
- A réteges szétválasztás ugyanakkor hosszabb távon is jó döntés, mert támogatja a világos szerkezetet, a kontrollált változtatást és az esetleges későbbi architekturális evolúciót.

## Következmények

- Pozitív következmények:
  - egyszerűbb telepítés és üzemeltetés
  - alacsonyabb operációs komplexitás
  - gyorsabb fejlesztés a jelenlegi méret mellett
  - könnyebb megértés a fejlesztőcsapat számára
  - jobb strukturáltság a rétegek és modulok miatt
  - jó kiindulópont a későbbi továbbfejlesztéshez
- Negatív következmények és trade-offok:
  - a backend nem skálázható olyan finoman, mint külön mikroszervizek esetén
  - fennáll a monolit eróziójának veszélye, ha a modulhatárokat nem tartják be következetesen
  - későbbi növekedés esetén architekturális refaktorálás válhat szükségessé
  - bizonyos funkciók eltérő terhelési profilja esetén a teljes backend együtt skálázódhat

## Elvetett alternatívák

- `Microservices architecture`
  - Nem ezt választottuk, mert a jelenlegi üzleti lépték és a várható induló terhelés mellett túl nagy operációs és fejlesztési komplexitást hozna.
  - Hátránya induláskor a több deployolható egység, az összetettebb kommunikáció, a nehezebb hibakeresés és a magasabb infrastruktúra-költség.
  - A projekt jelenlegi szakaszában a gyors megvalósítás és az egyszerű üzemeltetés fontosabb, mint a szolgáltatásonkénti független skálázás.
- `Egyszerű, strukturálatlan monolit`
  - Nem megfelelő, mert rövid távon ugyan egyszerűnek tűnhet, de nem biztosít elég világos felelősségi határokat.
  - Ez gyengébb karbantarthatósághoz és gyorsabb architekturális széteséshez vezethet.
- `Event-driven architecture mint elsődleges stílus`
  - Kiegészítő mintaként később hasznos lehet, de elsődleges architektúraként jelenleg túl összetett lenne.
  - A rendszer alapfolyamatai közvetlen, jól kontrollálható tranzakciós logikát igényelnek, különösen rendelés és fizetés esetén.

## Kapcsolódás a meglévő architektúrához

- A döntés közvetlenül visszatükröződik a meglévő `quickorder-system-context.dsl` fájlban.
- A modell egyetlen `Application Backend` konténert tartalmaz, amelynek leírása kifejezetten `Modular monolith backend`.
- A rendszer konténerszinten elkülöníti a `Web Application`, `Mobile Application`, `Application Backend` és `Database` elemeket.
- Ez azt mutatja, hogy a kliensalkalmazások, az üzleti logika és az adatkezelés világos szerkezeti egységekre vannak bontva.
- A backend komponensdiagramja réteges felelősségmegosztást mutat:
  - API komponensek: `Catalog API`, `Order API`, `Admin API`
  - alkalmazási szolgáltatások: `Cart Application Service`, `Order Application Service`, `Payment Application Service`, `Restaurant Admin Application Service`
  - domain modulok: `Catalog Domain Module`, `Cart Domain Module`, `Order Domain Module`
  - integrációs adapterek: `Payment Integration Adapter`, `Notification Integration Adapter`
  - perzisztencia: `Repository Layer`
- A kapcsolatok is ezt a döntést támasztják alá: az API-k az alkalmazási vagy domain elemek felé delegálnak, a domain és service komponensek a `Repository Layer` felé mennek, az integrációkat adapterek kezelik.
- A külső kapcsolatok szintén a választott architektúra mellett szólnak: a backend integrálódik a `External Payment Provider` és a `Notification Service` rendszerekkel, miközben a kliensoldali hozzáférést a webes és mobil konténerek biztosítják.
- A meglévő README is megerősíti, hogy a projekt a `layered modular monolith approach` szerint lett modellezve.

## Összegzés

- A QuickOrder jelenlegi érettségi szintjén és várható induló méretén a réteges architektúra és a moduláris monolit együtt adja a legjobb egyensúlyt az egyszerűség, a teljesíthetőség, a karbantarthatóság és a jövőbeli bővíthetőség között.
- A döntés nemcsak elméletileg indokolt, hanem a meglévő DSL-modellben is egyértelműen megjelenik.
- A mikroszervizekkel szemben ez a megközelítés jelenleg jobb választás, mert alacsonyabb komplexitás mellett is teljesíti a projekt funkcionális és nem funkcionális elvárásait.
