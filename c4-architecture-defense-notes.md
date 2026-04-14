# QuickOrder architektúra bemutatása

## 1. A rendszer rövid bemutatása

- A QuickOrder egy webalapú online rendeléskezelő platform kis éttermek és street food vállalkozások számára.
- Fő felhasználók: `Customer` és `Restaurant Admin`.
- A `Customer` éttermeket és menüket böngész, kosarat kezel, rendelést ad le, és követi a rendelés állapotát.
- A `Restaurant Admin` menüket, rendeléseket és promóciókat kezel.
- A rendszer azt a problémát oldja meg, hogy a kisebb vendéglátóhelyek is egységes digitális rendelési és adminisztrációs felületet kapjanak.
- Fő üzleti funkciók: étteremlista és menüböngészés, kosárkezelés, rendelésleadás, online fizetés, rendelési állapotkövetés, éttermi adminisztráció.

## 2. Kiinduló követelmények összefoglalása

- A kiinduló anyag alapján a rendszernek támogatnia kell az éttermek listázását, a menük böngészését, a kosár összeállítását, a rendelések leadását, az online fizetést, a rendelési státusz követését, valamint az éttermi oldali menü-, rendelés- és promóciókezelést.
- A legfontosabb nem funkcionális elvárások: gyors válaszidő, megfelelő skálázhatóság, egyszerű telepíthetőség, jó karbantarthatóság, megfelelő rendelkezésre állás, adatintegritás, külső rendszerekkel való kompatibilitás.
- Induló méret: kb. `10 000` felhasználó és kb. `100` étterem.
- Szükséges integrációk: webes kliens, mobil kliens iOS és Android támogatással, külső fizetési szolgáltató, értesítési szolgáltatás.
- Üzleti korlátok: gyors piacra lépés, egyszerű és megvalósítható induló architektúra, költség- és időhatékony fejlesztés.

## 3. Miért ezt az architektúrát választottuk?

- A DSL alapján a backend egyetlen `Application Backend` konténerként jelenik meg, amelyen belül modulok és rétegek különülnek el.
- Ez jól illeszkedik a `Layered Architecture` és a `Modular Monolith` kombinációjához.
- A réteges architektúra előnye, hogy világosan szétválasztja az API, az alkalmazási logika, a domain logika, az integráció és a perzisztencia felelősségeit.
- Ez közvetlenül támogatja a karbantarthatóságot, a tesztelhetőséget és az adatintegritást.
- A moduláris monolit jó választás az induló projektszakaszban, mert gyorsabban fejleszthető és telepíthető, mint egy mikroszerviz-alapú rendszer.
- A várható induló méret mellett ez elegendő skálázhatóságot ad, miközben az infrastruktúra és az üzemeltetés egyszerű marad.
- A `responsiveness` szempontjából előnyös, hogy a backend belső kommunikációja nem hálózati mikroszerviz-hívásokon alapul.
- A `deployability` szempontjából előnyös, hogy egy fő backend konténert kell buildelni, tesztelni és telepíteni.
- A `maintainability` szempontjából fontos, hogy a DSL-ben is elkülönülnek az API-k, application service-ek, domain modulok, adapterek és a repository réteg.
- Az `availability` szempontjából a kevesebb mozgó alkatrész kisebb operációs kockázatot jelent.
- A `data integrity` szempontjából a központi üzleti logika és az egységes adatkezelés kedvezőbb.
- A `feasibility / cost / implementation time` szempontjából ez a megközelítés jobban illik a gyors piacra lépéshez és a költséghatékony megvalósításhoz.
- A mikroszervizes indulás ebben a fázisban túl nagy komplexitást, hosszabb fejlesztési időt és magasabb infrastruktúra-költséget jelentene.

## 4. C4 modell 1. szint – Context diagram

- A context diagram azt mutatja meg, hogy a `QuickOrder` rendszer milyen szereplőkkel és külső rendszerekkel áll kapcsolatban.
- A DSL-ben szereplő fő szereplők: `Customer`, `Restaurant Admin`.
- A DSL-ben szereplő külső rendszerek: `External Payment Provider`, `Notification Service`.
- A QuickOrder szerepe a környezetében, hogy központi platformként összekapcsolja az ügyféloldali rendelést az éttermi adminisztrációval.
- A rendszer kezeli a rendelési folyamatot, és koordinálja a fizetési, illetve értesítési integrációkat.
- Fontos kapcsolatok a modellben: a `Customer` rendelést ad le és állapotot követ, a `Restaurant Admin` menüket és rendeléseket kezel, a rendszer fizetési szolgáltatóval és értesítési szolgáltatással kommunikál.
- Ez a szint kommunikációs szempontból azért hasznos, mert gyorsan és üzletileg is érthetően mutatja meg a rendszer határait és külső kapcsolatait.

## 5. C4 modell 2. szint – Container diagram

- A container diagram a QuickOrder fő futtatható egységeit mutatja meg.
- A DSL-ben szereplő konténerek: `Web Application` (`React`), `Mobile Application` (`React Native`), `Application Backend` (`Node.js`), `Database` (`PostgreSQL`).
- A `Web Application` böngészőben futó kliens, amelyen keresztül a vevői és adminisztrációs funkciók elérhetők.
- A `Mobile Application` mobil kliens a vásárlói folyamatokhoz: böngészés, rendelés, státuszkövetés.
- Az `Application Backend` a rendszer üzleti logikai központja; kezeli a böngészést, a kosarat, a rendelést, a fizetéskoordinációt és az adminisztrációt.
- A `Database` tárolja az éttermeket, menüket, kosarakat, rendeléseket, felhasználókat, promóciókat és fizetési rekordokat.
- A webes és mobil kliens a backend API-jait hívja.
- A backend a `Database` konténeren keresztül kezeli az adatokat.
- A backend kapcsolatban áll a `External Payment Provider` és a `Notification Service` rendszerekkel.
- Ez a szerkezet jól tükrözi a választott architektúrát: külön kliensréteg, külön adatbázis, és egyetlen deployolható backend konténer.
- Ez a konténerszintű felosztás jól alátámasztja a moduláris monolit megközelítést a jelenlegi projektszakaszban.

## 6. C4 modell 3. szint – Component diagram

- A 3. szint az `Application Backend` belső szerkezetét mutatja meg.
- Az API réteg komponensei: `Catalog API`, `Order API`, `Admin API`.
- Az alkalmazási szolgáltatások: `Cart Application Service`, `Order Application Service`, `Payment Application Service`, `Restaurant Admin Application Service`.
- A domain modulok: `Catalog Domain Module`, `Cart Domain Module`, `Order Domain Module`.
- Az integrációs komponensek: `Payment Integration Adapter`, `Notification Integration Adapter`.
- A perzisztencia réteg fő eleme: `Repository Layer`.
- A `Catalog API` a böngészési kéréseket a `Catalog Domain Module` felé vezeti.
- Az `Order API` az `Order Application Service` és a `Cart Application Service` felé delegál.
- Az `Admin API` a `Restaurant Admin Application Service` komponenshez kapcsolódik.
- A `Cart Application Service` a `Cart Domain Module` üzleti szabályait használja.
- Az `Order Application Service` az `Order Domain Module` szabályait alkalmazza, fizetést kér a `Payment Application Service` segítségével, és értesítéseket indít a `Notification Integration Adapter` felé.
- A `Payment Application Service` a `Payment Integration Adapter` közvetítésével éri el a külső fizetési szolgáltatót.
- A domain modulok és az adminisztrációs szolgáltatás a `Repository Layer` segítségével érnek el adatokat.
- A diagram jól mutatja a réteges architektúrát: vezérlő/API réteg, application service réteg, domain réteg, integrációs réteg, repository réteg.
- A diagram ugyanakkor a moduláris monolit gondolkodást is tükrözi, mert egyetlen backend egységen belül különülnek el a katalógus-, kosár-, rendelés-, adminisztrációs és fizetési felelősségek.

## 7. Az architektúra előnyei és korlátai

- Fő előnyök: egyszerűbb fejlesztés, gyorsabb indulás, kisebb üzemeltetési komplexitás, jobb átláthatóság, kedvezőbb adatintegritás.
- További előny, hogy a C4 modell mind üzleti, mind technikai oldalról jól kommunikálhatóvá teszi a rendszert.
- Jelenlegi korlát, hogy a backend egyetlen konténer, ezért a skálázás kevésbé finom szemcséjű.
- Kockázat, hogy a monolit növekedésével romolhat az átláthatóság, ha a belső modulhatárok nem maradnak következetesek.
- Trade-off, hogy az egyszerűbb induló architektúra később refaktorálást igényelhet.
- Jövőbeli evolúció akkor lehet indokolt, ha jelentősen nő a felhasználószám vagy a rendelési terhelés, ha bizonyos modulok eltérő skálázási igényűvé válnak, vagy ha több külső integráció és bonyolultabb üzleti folyamat jelenik meg.

## 8. Összegzés

- A QuickOrder jelenlegi szakaszában a réteges, moduláris monolit architektúra jó egyensúlyt ad az egyszerűség, a megvalósíthatóság és a bővíthetőség között.
- A DSL-ben modellezett C4 nézetek jól támogatják a bemutatást: az 1. szint az üzleti környezetet, a 2. szint a fő technikai építőelemeket, a 3. szint a backend belső logikai szerkezetét mutatja meg.
- A legfontosabb architekturális üzenet az, hogy a rendszer induláskor tudatosan nem túlkomplikált, mégis jól strukturált és később továbbfejleszthető alapokra épül.
