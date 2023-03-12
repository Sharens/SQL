# Treść zadania
Projekt architektury bazy danych obsługującej procesy związane z kształceniem w uczelni wyższej. <br />
Przykładowe tabele: (studenci, wykładowcy, przedmioty, kursy, kierunki, plan zajęć, egzaminy, oceny itp.)

Projektując bazę należy wykorzystać formaty nierelacyjne (dokumentowe, przestrzenne, grafowe).<br /> 
Uzasadnienie wykorzystanie danego formatu - mile widziane.

**Projekt powinien uwzględniać min. 10 obiektów (tabel) wraz z powiązaniami.** 
<br />
<br />

# Schemat bazy danych
```mermaid
erDiagram
    STUDENCI {
        id_studenta INT PK
        imie VARCHAR
        nazwisko VARCHAR
        data_urodzenia DATE
        kierunek VARCHAR
        rok_studiow INT
        adres VARCHAR
        numer_telefonu VARCHAR
    }
    KURSY {
        id_kursu INT PK
        nazwa_kursu VARCHAR
        liczba_godzin INT
        opis VARCHAR
        wymagania VARCHAR
    }
    OCENY {
        id_oceny INT PK
        id_studenta INT FK
        id_kursu INT FK
        rodzaj_oceny VARCHAR
        punkty_ects INT
    }
    NAUCZYCIELE {
        id_nauczyciela INT PK
        imie VARCHAR
        nazwisko VARCHAR
        tytul_naukowy VARCHAR
        stopien_naukowy VARCHAR
        dzial_nauczyciela VARCHAR
    }
    SALE {
        numer_sali INT PK
        pojemnosc INT
        dostepnosc VARCHAR
    }
    WYDZIALY {
        id_wydzialu INT PK
        nazwa_wydzialu VARCHAR
        kierunki_studiow VARCHAR
        opis_wydzialu VARCHAR
    }
    ZAPISY {
        id_zapisu INT PK
        id_studenta INT FK
        id_kursu INT FK
        id_grupy INT FK
        status_zapisu VARCHAR
        data_zapisu DATE
    }
    PRZEDMIOTY {
        id_przedmiotu INT PK
        nazwa_przedmiotu VARCHAR
        liczba_ects INT
    }
    GRUPY_ZAJECIOWE {
        id_grupy INT PK
        id_kursu INT FK
        numer_grupy INT
        liczba_studentow INT
        data_rozpoczecia DATE
    }
    PLAN_ZAJEC {
        id_planu INT PK
        id_grupy INT FK
        id_sali INT FK
        id_nauczyciela INT FK
        id_kursu INT FK
        dzien_tygodnia VARCHAR
        godzina_rozpoczecia TIME
        godzina_zakonczenia TIME
    }
    STUDENCI }|..|| OCENY: "dostają"
    KURSY }|..|| OCENY: "wchodzą w skład"
    STUDENCI }|--|| ZAPISY: "dotyczą"
    KURSY }|--|| ZAPISY: "dotyczą"
    GRUPY_ZAJECIOWE }|--|| ZAPISY: "tworzą"
    KURSY }|--|{ GRUPY_ZAJECIOWE: "uczęszczają"
    KURSY }|--|{ PLAN_ZAJEC: "określa"
    SALE }|--|{ PLAN_ZAJEC: "określa"
    NAUCZYCIELE }|--|{ PLAN_ZAJEC: "określa"
    KURSY }|--|| PRZEDMIOTY: "wchodzą w skład"
    WYDZIALY }|--|| STUDENCI: "wchodzi w skład"
    WYDZIALY }|--|| KURSY: "wchodzi w skład"
    WYDZIALY }|--|| PRZEDMIOTY: "wchodzi w skład"
    WYDZIALY }|--|| NAUCZYCIELE: "wchodzi w skład"
    WYDZIALY }|--|| GRUPY_ZAJECIOWE: "wchodzi w skład"
    WYDZIALY }|--|| SALE: "wchodzi w skład"
```
Powyższy diagram ER przedstawia relacje między tabelami obecnymi w systemie zarządzania uniwersytetem:

- Tabela `STUDENCI` przechowuje informacje o studentach, takie jak ich imię, nazwisko, datę urodzenia, kierunek studiów, rok studiów, adres i numer telefonu.

- Tabela `KURSY` przechowuje informacje o kursach, takie jak nazwa kursu, liczba godzin, opis i wymagania.

- Tabela `OCENY` przechowuje informacje o ocenach studentów, takie jak rodzaj oceny i liczba punktów ECTS. Tabela ta zawiera klucze obce do tabel STUDENCI i KURSY.

- Tabela `NAUCZYCIELE` przechowuje informacje o nauczycielach, takie jak ich imię, nazwisko, tytuł naukowy, stopień naukowy i dział nauczyciela.

- Tabela `SALE` przechowuje informacje o salach, takie jak pojemność i dostępność.

- Tabela `WYDZIALY` przechowuje informacje o wydziałach, takie jak nazwa, kierunki studiów i opis.

- Tabela `ZAPISY` przechowuje informacje o zapisach studentów na kursy. Tabela ta zawiera klucze obce do tabel STUDENCI, KURSY i GRUPY_ZAJECIOWE.

- Tabela `PRZEDMIOTY` przechowuje informacje o przedmiotach, takie jak nazwa, liczba punktów ECTS i poziom trudności.

- Tabela `GRUPY_ZAJECIOWE` przechowuje informacje o grupach zajęciowych, takie jak numer grupy, liczba studentów i data rozpoczęcia. Tabela ta zawiera klucz obcy do tabeli `KURSY`.

- Tabela `PLAN_ZAJEC` przechowuje informacje o planie zajęć, takie jak dzień tygodnia, godzina rozpoczęcia i zakończenia zajęć. Tabela ta zawiera klucze obce do tabel `GRUPY_ZAJECIOWE`, `SALE`, `NAUCZYCIELE` i `KURSY`.

Diagram ER pokazuje, że tabela STUDENCI i KURSY zawierają wiele rekordów, które są powiązane z rekordami w tabeli OCENY. Tabela STUDENCI i KURSY zawierają również wiele rekordów, które są powiązane z rekordami w tabeli ZAPISY. Tabela KURSY zawiera wiele rekordów, które są powiązane z rekordami w tabeli GRUPY_ZAJECIOWE i PLAN_ZAJEC. 

# Wykorzystanie nierelacyjnej bazy danych

Biorąc pod uwagę strukturę i relacje między tabelami, tabela "OCENY" byłaby najłatwiejsza do przeniesienia do MongoDB.
Wynika to z faktu, że tabela ta składa się tylko z kilku kolumn i nie zawiera złożonych relacji z innymi tabelami.<br /> 

W MongoDB można by utworzyć kolekcję "oceny", a każdy dokument w tej kolekcji mógłby przechowywać informacje o ocenie jednego studenta w danym przedmiocie. Na przykład, dokument może mieć następującą strukturę:

```
{
  "id_studenta": 1,
  "id_kursu": 1,
  "ocena": 4.5,
  "semestr": "zimowy",
  "rok": 2022
}
```


Taka struktura pozwoliłaby na łatwe wyszukiwanie ocen studentów dla konkretnych przedmiotów, semestrów lub lat. Ponadto, MongoDB jest idealnym wyborem do przechowywania danych nierelacyjnych, co oznacza, że łatwo można by dodać nowe pola do dokumentów lub zmienić strukturę kolekcji, jeśli zajdzie taka potrzeba.
