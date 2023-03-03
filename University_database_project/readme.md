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
        poziom_trudnosci VARCHAR
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
    STUDENCI }|..|| OCENY: "zawiera"
    KURSY }|..|| OCENY: "zawiera"
    STUDENCI }|--|| ZAPISY: "zawiera"
    KURSY }|--|| ZAPISY: "zawiera"
    GRUPY_ZAJECIOWE }|--|| ZAPISY: "zawiera"
    KURSY }|--|{ GRUPY_ZAJECIOWE: "zawiera"
    KURSY }|--|{ PLAN_ZAJEC: "zawiera"
    SALE }|--|{ PLAN_ZAJEC: "zawiera"
    NAUCZYCIELE }|--|{ PLAN_ZAJEC: "zawiera"
    KURSY }|--|| PRZEDMIOTY: "zawiera"
    WYDZIALY }|--|| STUDENCI: "zawiera"
    WYDZIALY }|--|| KURSY: "zawiera"
    WYDZIALY }|--|| PRZEDMIOTY: "zawiera"
    WYDZIALY }|--|| NAUCZYCIELE: "zawiera"
    WYDZIALY }|--|| GRUPY_ZAJECIOWE: "zawiera"
    WYDZIALY }|--|| SALE: "zawiera"
```

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