module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onMouseOver, onMouseDown, onClick)
import Complete.Selector as S
import Complete as A
import Complete.Bulma exposing (..)


type alias Movie =
    { name : String, director : String }


type alias Model =
    { movie : A.State Movie
    , country : A.State String
    }


model : Model
model =
    { movie = A.initState
    , country = A.initState
    }


accounts =
    [ { name = "The Empire Strikes Back", director = "Irvin Kershner" }
    , { name = "Star Wars", director = "George Lucas" }
    ]


main =
    Html.beginnerProgram { model = model, update = update, view = view }


type Msg
    = SelectAccount (A.Msg Movie)
    | SelectCountry (A.Msg String)


update : Msg -> Model -> Model
update msg model =
    case msg of
        SelectAccount op ->
            { model | movie = model.movie |> A.update .name accounts op }

        SelectCountry op ->
            { model | country = model.country |> A.update identity countries op }


view : Model -> Html Msg
view model =
    div []
        [ bulma
        , section [ class "section" ]
            [ div [ class "container" ]
                [ model.movie |> autoComplInput (.name >> text) "Movie" |> Html.map SelectAccount
                , model.country |> autoComplInput text "Country" |> Html.map SelectCountry
                ]
            ]
        ]


bulma =
    css "https://cdnjs.cloudflare.com/ajax/libs/bulma/0.6.1/css/bulma.min.css"


foundation =
    css "https://cdnjs.cloudflare.com/ajax/libs/foundation/6.4.3/css/foundation.min.css"


css : String -> Html msg
css path =
    node "link" [ rel "stylesheet", href path ] []


countries =
    [ "Afghanistan"
    , "Åland Islands"
    , "Albania"
    , "Algeria"
    , "American Samoa"
    , "AndorrA"
    , "Angola"
    , "Anguilla"
    , "Antarctica"
    , "Antigua and Barbuda"
    , "Argentina"
    , "Armenia"
    , "Aruba"
    , "Australia"
    , "Austria"
    , "Azerbaijan"
    , "Bahamas"
    , "Bahrain"
    , "Bangladesh"
    , "Barbados"
    , "Belarus"
    , "Belgium"
    , "Belize"
    , "Benin"
    , "Bermuda"
    , "Bhutan"
    , "Bolivia"
    , "Bosnia and Herzegovina"
    , "Botswana"
    , "Bouvet Island"
    , "Brazil"
    , "British Indian Ocean Territory"
    , "Brunei Darussalam"
    , "Bulgaria"
    , "Burkina Faso"
    , "Burundi"
    , "Cambodia"
    , "Cameroon"
    , "Canada"
    , "Cape Verde"
    , "Cayman Islands"
    , "Central African Republic"
    , "Chad"
    , "Chile"
    , "China"
    , "Christmas Island"
    , "Cocos (Keeling) Islands"
    , "Colombia"
    , "Comoros"
    , "Congo"
    , "Congo, The Democratic Republic of the"
    , "Cook Islands"
    , "Costa Rica"
    , "Cote D\"Ivoire"
    , "Croatia"
    , "Cuba"
    , "Cyprus"
    , "Czech Republic"
    , "Denmark"
    , "Djibouti"
    , "Dominica"
    , "Dominican Republic"
    , "Ecuador"
    , "Egypt"
    , "El Salvador"
    , "Equatorial Guinea"
    , "Eritrea"
    , "Estonia"
    , "Ethiopia"
    , "Falkland Islands (Malvinas)"
    , "Faroe Islands"
    , "Fiji"
    , "Finland"
    , "France"
    , "French Guiana"
    , "French Polynesia"
    , "French Southern Territories"
    , "Gabon"
    , "Gambia"
    , "Georgia"
    , "Germany"
    , "Ghana"
    , "Gibraltar"
    , "Greece"
    , "Greenland"
    , "Grenada"
    , "Guadeloupe"
    , "Guam"
    , "Guatemala"
    , "Guernsey"
    , "Guinea"
    , "Guinea-Bissau"
    , "Guyana"
    , "Haiti"
    , "Heard Island and Mcdonald Islands"
    , "Holy See (Vatican City State)"
    , "Honduras"
    , "Hong Kong"
    , "Hungary"
    , "Iceland"
    , "India"
    , "Indonesia"
    , "Iran, Islamic Republic Of"
    , "Iraq"
    , "Ireland"
    , "Isle of Man"
    , "Israel"
    , "Italy"
    , "Jamaica"
    , "Japan"
    , "Jersey"
    , "Jordan"
    , "Kazakhstan"
    , "Kenya"
    , "Kiribati"
    , "Korea, Democratic People\"S Republic of"
    , "Korea, Republic of"
    , "Kuwait"
    , "Kyrgyzstan"
    , "Lao People\"S Democratic Republic"
    , "Latvia"
    , "Lebanon"
    , "Lesotho"
    , "Liberia"
    , "Libyan Arab Jamahiriya"
    , "Liechtenstein"
    , "Lithuania"
    , "Luxembourg"
    , "Macao"
    , "Macedonia, The Former Yugoslav Republic of"
    , "Madagascar"
    , "Malawi"
    , "Malaysia"
    , "Maldives"
    , "Mali"
    , "Malta"
    , "Marshall Islands"
    , "Martinique"
    , "Mauritania"
    , "Mauritius"
    , "Mayotte"
    , "Mexico"
    , "Micronesia, Federated States of"
    , "Moldova, Republic of"
    , "Monaco"
    , "Mongolia"
    , "Montserrat"
    , "Morocco"
    , "Mozambique"
    , "Myanmar"
    , "Namibia"
    , "Nauru"
    , "Nepal"
    , "Netherlands"
    , "Netherlands Antilles"
    , "New Caledonia"
    , "New Zealand"
    , "Nicaragua"
    , "Niger"
    , "Nigeria"
    , "Niue"
    , "Norfolk Island"
    , "Northern Mariana Islands"
    , "Norway"
    , "Oman"
    , "Pakistan"
    , "Palau"
    , "Palestinian Territory, Occupied"
    , "Panama"
    , "Papua New Guinea"
    , "Paraguay"
    , "Peru"
    , "Philippines"
    , "Pitcairn"
    , "Poland"
    , "Portugal"
    , "Puerto Rico"
    , "Qatar"
    , "Reunion"
    , "Romania"
    , "Russian Federation"
    , "RWANDA"
    , "Saint Helena"
    , "Saint Kitts and Nevis"
    , "Saint Lucia"
    , "Saint Pierre and Miquelon"
    , "Saint Vincent and the Grenadines"
    , "Samoa"
    , "San Marino"
    , "Sao Tome and Principe"
    , "Saudi Arabia"
    , "Senegal"
    , "Serbia and Montenegro"
    , "Seychelles"
    , "Sierra Leone"
    , "Singapore"
    , "Slovakia"
    , "Slovenia"
    , "Solomon Islands"
    , "Somalia"
    , "South Africa"
    , "South Georgia and the South Sandwich Islands"
    , "Spain"
    , "Sri Lanka"
    , "Sudan"
    , "Suriname"
    , "Svalbard and Jan Mayen"
    , "Swaziland"
    , "Sweden"
    , "Switzerland"
    , "Syrian Arab Republic"
    , "Taiwan, Province of China"
    , "Tajikistan"
    , "Tanzania, United Republic of"
    , "Thailand"
    , "Timor-Leste"
    , "Togo"
    , "Tokelau"
    , "Tonga"
    , "Trinidad and Tobago"
    , "Tunisia"
    , "Turkey"
    , "Turkmenistan"
    , "Turks and Caicos Islands"
    , "Tuvalu"
    , "Uganda"
    , "Ukraine"
    , "United Arab Emirates"
    , "United Kingdom"
    , "United States"
    , "United States Minor Outlying Islands"
    , "Uruguay"
    , "Uzbekistan"
    , "Vanuatu"
    , "Venezuela"
    , "Viet Nam"
    , "Virgin Islands, British"
    , "Virgin Islands, U.S."
    , "Wallis and Futuna"
    , "Western Sahara"
    , "Yemen"
    , "Zambia"
    , "Zimbabwe"
    ]
