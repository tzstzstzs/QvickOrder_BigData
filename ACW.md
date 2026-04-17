# Architecture Characteristic Worksheet

**System/Project:** QuickOrder – Online rendeléskezelő platform  
**Domain/Quantum:** Webalapú éttermi rendeléskezelő rendszer, induláskor kb. tízezer felhasználó és kb. száz étterem  
**Architect/Team:** Tarr Zsolt, Bence Balázs, Kosztur Judit  
**Date:** 2026.04.14.  
**Next Review:** -

---

## Driving Characteristics (max 7)

1. **Responsiveness** – gyors válaszidő a felhasználóknak  
2. **Scalability** – növekvő terhelés kezelése  
3. **Deployability** – gyors és egyszerű kiadás  
4. **Maintainability** – könnyű módosíthatóság és bővíthetőség  
5. **Availability** – folyamatos elérhetőség  
6. **Data Integrity** – adatok pontossága és konzisztenciája  
7. **Feasibility (cost/time)** – megvalósíthatóság idő és költség szempontból  

---

## Top 3 Driving Characteristics

### Responsiveness (NFR1)
A rendszernek gyors válaszidőt kell biztosítania, mivel a felhasználók valós időben adnak le rendeléseket.

### Scalability (NFR2)
A növekvő felhasználó- és étteremszám miatt a rendszernek könnyen bővíthetőnek kell lennie.

### Deployability (NFR2, NFR3)
A gyors piacra lépés és a folyamatos frissítések miatt fontos, hogy a rendszer gyorsan és egyszerűen telepíthető legyen.

---

## Implicit Characteristics

- **Feasibility (cost/time) (NFR3):** A rendszernek megvalósíthatónak kell lennie a rendelkezésre álló idő- és költségkereten belül.  
- **Maintainability (NFR6):** A kód legyen könnyen karbantartható, hogy a későbbi módosítások és bővítések egyszerűek legyenek.  
- **Availability (NFR3):** A rendszernek üzleti időben folyamatosan elérhetőnek kell lennie.  
- **Data Integrity (NFR4):** A rendelések és fizetések miatt biztosítani kell az adatok pontosságát és konzisztenciáját.  
- **Compatibility (NFR7):** iOS, Android és webes felület kompatibilitás, valamint integráció támogatása.  

---

## Others Considered

- **Security** – az adatok védelme fontos, de jelen esetben nem a legkritikusabb architekturális hajtóerő  
- **Usability** – a felhasználói élmény fontos, de inkább frontend szintű kérdés  
- **Testability** – a rendszer tesztelhetősége fontos, de nem elsődleges döntési tényező  
- **Performance (resource efficiency)** – erőforrás-használat optimalizálása nem kritikus ebben a fázisban  