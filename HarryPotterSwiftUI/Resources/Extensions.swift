//
//  Extensions.swift
//  HarryPotterSwiftUI
//
//  Created by Sunnatbek on 03/08/25.
//

import Foundation

extension HPCharacter {
    static let mockCharacter = HPCharacter(
        id: "1",
        type: "character",
        attributes: HPCharacterAttributes(
            slug: "harry-potter",
            alias_names: ["The Boy Who Lived", "The Chosen One"],
            animagus: nil,
            blood_status: "Half-blood",
            boggart: "Dementor",
            born: "31 July 1980",
            died: nil,
            eye_color: "Bright green",
            family_members: [
                "James Potter (father)",
                "Lily Potter (mother)",
                "Ginny Potter (wife)",
                "James Potter II (son)",
                "Albus Potter (son)",
                "Lily Potter II (daughter)"
            ],
            gender: "Male",
            hair_color: "Jet black",
            height: "5'8\"",
            house: "Gryffindor",
            image: "https://hp-api.onrender.com/images/harry.jpg",
            jobs: ["Auror", "Head of the Auror Office"],
            marital_status: "Married",
            name: "Harry Potter",
            nationality: "English",
            patronus: "Stag",
            romances: ["Cho Chang", "Ginny Weasley"],
            skin_color: "Light",
            species: "Human",
            titles: ["Seeker", "Triwizard Champion", "Master of Death"],
            wands: [
                "11', Holly, Phoenix Feather",
                "10¾', Vine, Dragon Heartstring (temporary)"
            ],
            weight: "75kg",
            wiki: "https://harrypotter.fandom.com/wiki/Harry_Potter"
        ),
        links: HPCharacterLinks(self: "https://hp-api.onrender.com/characters/harry-potter")
    )
}

extension HPBook {
    static let mockBook = HPBook(
        id: "1",
        type: "book",
        attributes: HPBookAttributes(
            slug: "harry-potter-and-the-philosophers-stone",
            author: "J.K. Rowling",
            cover: "https://example.com/hp1-cover.jpg",
            dedication: "For Jessica, who loves stories, for Anne, who loved them too, and for Di, who heard this one first.",
            pages: 223,
            release_date: "1997-06-26",
            summary: "Harry Potter discovers he is a wizard on his 11th birthday and begins his magical journey at Hogwarts School of Witchcraft and Wizardry.",
            title: "Harry Potter and the Philosopher's Stone",
            wiki: "https://harrypotter.fandom.com/wiki/Harry_Potter_and_the_Philosopher%27s_Stone"
        ),
        relationships: HPBookRelationships(
            chapters: HPBookRelationshipChapters(
                data: [
                    HPBookRelationshipChaptersData(type: "chapter", id: "1"),
                    HPBookRelationshipChaptersData(type: "chapter", id: "2"),
                    HPBookRelationshipChaptersData(type: "chapter", id: "3")
                ]
            )
        ),
        links: HPBookLinks(
            self: "https://api.harrypotterbooks.com/books/1"
        )
    )
    
    static let mockList: [HPBook] = [
        .mockBook,
        HPBook(
            id: "2",
            type: "book",
            attributes: HPBookAttributes(
                slug: "harry-potter-and-the-chamber-of-secrets",
                author: "J.K. Rowling",
                cover: "https://example.com/hp2-cover.jpg",
                dedication: "For Sean P. F. Harris, getaway driver and foul-weather friend.",
                pages: 251,
                release_date: "1998-07-02",
                summary: "Harry returns for his second year at Hogwarts where a mysterious force is petrifying students and terrifying the school.",
                title: "Harry Potter and the Chamber of Secrets",
                wiki: "https://harrypotter.fandom.com/wiki/Harry_Potter_and_the_Chamber_of_Secrets"
            ),
            relationships: HPBookRelationships(
                chapters: HPBookRelationshipChapters(
                    data: [
                        HPBookRelationshipChaptersData(type: "chapter", id: "1"),
                        HPBookRelationshipChaptersData(type: "chapter", id: "2"),
                        HPBookRelationshipChaptersData(type: "chapter", id: "3")
                    ]
                )
            ),
            links: HPBookLinks(
                self: "https://api.harrypotterbooks.com/books/2"
            )
        )
    ]
}

extension HPMovie {
    static let mockMovie = HPMovie(
        id: "1",
        type: "movie",
        attributes: HPMovieAttributes(
            slug: "harry-potter-and-the-philosophers-stone",
            box_office: "$1,017,000,000",
            budget: "$125,000,000",
            cinematographers: ["John Seale"],
            directors: ["Chris Columbus"],
            distributors: ["Warner Bros. Pictures"],
            editors: ["Richard Francis-Bruce"],
            music_composers: ["John Williams"],
            poster: "https://example.com/hp1-movie-poster.jpg",
            producers: ["David Heyman"],
            rating: "PG",
            release_date: "2001-11-16",
            running_time: "152 minutes",
            screenwriters: ["Steve Kloves"],
            summary: "Harry Potter discovers his magical heritage on his 11th birthday and embarks on his first year at Hogwarts School of Witchcraft and Wizardry.",
            title: "Harry Potter and the Philosopher's Stone",
            trailer: "https://youtube.com/watch?v=VyHV0BRtdxo",
            wiki: "https://harrypotter.fandom.com/wiki/Harry_Potter_and_the_Philosopher%27s_Stone_(film)"
        ),
        links: HPMovieLinks(
            self: "https://api.harrypottermovies.com/movies/1"
        )
    )
    
    static let mockList: [HPMovie] = [
        .mockMovie,
        HPMovie(
            id: "2",
            type: "movie",
            attributes: HPMovieAttributes(
                slug: "harry-potter-and-the-chamber-of-secrets",
                box_office: "$879,000,000",
                budget: "$100,000,000",
                cinematographers: ["Roger Pratt"],
                directors: ["Chris Columbus"],
                distributors: ["Warner Bros. Pictures"],
                editors: ["Peter Honess"],
                music_composers: ["John Williams"],
                poster: "https://example.com/hp2-movie-poster.jpg",
                producers: ["David Heyman"],
                rating: "PG",
                release_date: "2002-11-15",
                running_time: "161 minutes",
                screenwriters: ["Steve Kloves"],
                summary: "Harry Potter returns for his second year at Hogwarts, where a mysterious entity is turning students to stone and the Chamber of Secrets has been opened again.",
                title: "Harry Potter and the Chamber of Secrets",
                trailer: "https://youtube.com/watch?v=1bq0qff4iF8",
                wiki: "https://harrypotter.fandom.com/wiki/Harry_Potter_and_the_Chamber_of_Secrets_(film)"
            ),
            links: HPMovieLinks(
                self: "https://api.harrypottermovies.com/movies/2"
            )
        )
    ]
}

extension HPPotion {
    static let mockPotion = HPPotion(
        id: "1",
        type: "potion",
        attributes: HPPotionAttributes(
            slug: "polyjuice-potion",
            characteristics: "Thick, mud-like consistency",
            difficulty: "Advanced",
            effect: "Allows the drinker to assume the form of someone else",
            image: "https://example.com/polyjuice-potion.jpg",
            inventors: "Unknown (improved by Horace Slughorn)",
            ingredients: "Lacewing flies, Leeches, Powdered Bicorn Horn, Knotgrass, Fluxweed, Shredded Boomslang skin",
            manufacturers: "N/A",
            name: "Polyjuice Potion",
            side_effects: "If brewed incorrectly, can cause severe side effects including partial transformations",
            time: "Takes a month to brew",
            wiki: "https://harrypotter.fandom.com/wiki/Polyjuice_Potion"
        ),
        links: HPPotionLinks(
            self: "https://api.harrypotterpotions.com/potions/1",
            current: nil
        )
    )
    
    static let mockList: [HPPotion] = [
        .mockPotion,
        HPPotion(
            id: "2",
            type: "potion",
            attributes: HPPotionAttributes(
                slug: "felix-felicis",
                characteristics: "Golden, glowing liquid",
                difficulty: "Advanced",
                effect: "Grants temporary good luck",
                image: "https://example.com/felix-felicis.jpg",
                inventors: "Zygmunt Budge",
                ingredients: "Ashwinder egg, Squill bulb, Murtlap tentacle, Tincture of thyme, Occamy eggshell, Powdered common rue",
                manufacturers: nil,
                name: "Felix Felicis",
                side_effects: "Overuse can cause recklessness and dangerous overconfidence",
                time: "Takes six months to prepare",
                wiki: "https://harrypotter.fandom.com/wiki/Felix_Felicis"
            ),
            links: HPPotionLinks(
                self: "https://api.harrypotterpotions.com/potions/2",
                current: "https://api.harrypotterpotions.com/potions/2"
            )
        )
    ]
}

extension HPSpell {
    static let mockSpell = HPSpell(
        id: "1",
        type: "spell",
        attributes: HPSpellAttributes(
            slug: "expelliarmus",
            category: "Charm",
            creator: "Unknown",
            effect: "Disarms your opponent",
            hand: "Right",
            image: "https://example.com/expelliarmus.jpg",
            incantation: "Expelliarmus",
            light: "Red",
            name: "Expelliarmus",
            wiki: "https://harrypotter.fandom.com/wiki/Expelliarmus"
        ),
        links: HPSpellLinks(
            self: "https://hp-api.example.com/spells/expelliarmus"
        )
    )
    
    static let mockList: [HPSpell] = [
        .mockSpell,
        HPSpell(
            id: "2",
            type: "spell",
            attributes: HPSpellAttributes(
                slug: "lumos",
                category: "Charm",
                creator: "Unknown",
                effect: "Produces light from wand tip",
                hand: "Either",
                image: "https://example.com/lumos.jpg",
                incantation: "Lumos",
                light: "White",
                name: "Lumos",
                wiki: "https://harrypotter.fandom.com/wiki/Lumos"
            ),
            links: HPSpellLinks(
                self: "https://hp-api.example.com/spells/lumos"
            )
        )
    ]
}
