CREATE TABLE public.species (
  id         uuid    PRIMARY KEY DEFAULT gen_random_uuid(),
  name       text    NOT NULL UNIQUE,
  sort_order integer NOT NULL DEFAULT 99
);

CREATE TABLE public.breeds (
  id         uuid    PRIMARY KEY DEFAULT gen_random_uuid(),
  species_id uuid    NOT NULL REFERENCES public.species(id) ON DELETE CASCADE,
  name       text    NOT NULL,
  sort_order integer NOT NULL DEFAULT 99
);

ALTER TABLE public.species ENABLE ROW LEVEL SECURITY;
CREATE POLICY "read_all" ON public.species FOR SELECT USING (true);
GRANT SELECT ON public.species TO authenticated, anon;

ALTER TABLE public.breeds ENABLE ROW LEVEL SECURITY;
CREATE POLICY "read_all" ON public.breeds FOR SELECT USING (true);
GRANT SELECT ON public.breeds TO authenticated, anon;

-- Species sorted by popularity (spec order)
INSERT INTO public.species (name, sort_order) VALUES
  ('Dog',        1),
  ('Cat',        2),
  ('Rabbit',     3),
  ('Hamster',    4),
  ('Guinea pig', 5),
  ('Parrot',     6),
  ('Fish',       7),
  ('Turtle',     8),
  ('Snake',      9),
  ('Ferret',     10),
  ('Chinchilla', 11),
  ('Lizard',     12),
  ('Hedgehog',   13),
  ('Frog',       14);

-- Dog breeds sorted by popularity
INSERT INTO public.breeds (species_id, name, sort_order)
SELECT s.id, b.name, b.ord
FROM public.species s
CROSS JOIN (VALUES
  ('Labrador Retriever',           1),
  ('Golden Retriever',             2),
  ('German Shepherd',              3),
  ('French Bulldog',               4),
  ('Bulldog',                      5),
  ('Poodle',                       6),
  ('Beagle',                       7),
  ('Rottweiler',                   8),
  ('Siberian Husky',               9),
  ('Dachshund',                    10),
  ('Yorkshire Terrier',            11),
  ('Boxer',                        12),
  ('Border Collie',                13),
  ('Chihuahua',                    14),
  ('Doberman Pinscher',            15),
  ('Great Dane',                   16),
  ('Pomeranian',                   17),
  ('Shih Tzu',                     18),
  ('Australian Shepherd',          19),
  ('Pembroke Welsh Corgi',         20),
  ('Bernese Mountain Dog',         21),
  ('Cavalier King Charles Spaniel',22),
  ('Cocker Spaniel',               23),
  ('Miniature Schnauzer',          24),
  ('Boston Terrier',               25),
  ('Bichon Frise',                 26),
  ('Maltese',                      27),
  ('Akita',                        28),
  ('Samoyed',                      29),
  ('Alaskan Malamute',             30),
  ('Weimaraner',                   31),
  ('Dalmatian',                    32),
  ('Bullmastiff',                  33),
  ('Cane Corso',                   34),
  ('Shetland Sheepdog',            35),
  ('Jack Russell Terrier',         36),
  ('Belgian Malinois',             37),
  ('Shiba Inu',                    38),
  ('Rhodesian Ridgeback',          39),
  ('Vizsla',                       40),
  ('Irish Setter',                 41),
  ('Newfoundland',                 42),
  ('German Shorthaired Pointer',   43),
  ('Havanese',                     44),
  ('Whippet',                      45),
  ('Papillon',                     46),
  ('Collie',                       47),
  ('English Springer Spaniel',     48),
  ('Pit Bull Terrier',             49),
  ('Basset Hound',                 50),
  ('Bloodhound',                   51),
  ('Chow Chow',                    52),
  ('Saint Bernard',                53),
  ('Lhasa Apso',                   54),
  ('Chinese Shar-Pei',             55),
  ('Scottish Terrier',             56),
  ('West Highland White Terrier',  57),
  ('Afghan Hound',                 58),
  ('Greyhound',                    59),
  ('Irish Wolfhound',              60),
  ('Nova Scotia Duck Tolling Retriever', 61)
) AS b(name, ord)
WHERE s.name = 'Dog';

-- Cat breeds sorted by popularity
INSERT INTO public.breeds (species_id, name, sort_order)
SELECT s.id, b.name, b.ord
FROM public.species s
CROSS JOIN (VALUES
  ('Persian',             1),
  ('Maine Coon',          2),
  ('Siamese',             3),
  ('British Shorthair',   4),
  ('Ragdoll',             5),
  ('Bengal',              6),
  ('Sphynx',              7),
  ('Scottish Fold',       8),
  ('Abyssinian',          9),
  ('Norwegian Forest Cat',10),
  ('American Shorthair',  11),
  ('Devon Rex',           12),
  ('Burmese',             13),
  ('Russian Blue',        14),
  ('Oriental Shorthair',  15),
  ('Himalayan',           16),
  ('Exotic Shorthair',    17),
  ('Birman',              18),
  ('Savannah',            19),
  ('Tonkinese',           20),
  ('Balinese',            21),
  ('Manx',                22),
  ('Turkish Angora',      23),
  ('Bombay',              24),
  ('Egyptian Mau',        25),
  ('Chartreux',           26),
  ('Cornish Rex',         27),
  ('Somali',              28),
  ('Selkirk Rex',         29),
  ('Ocicat',              30),
  ('Turkish Van',         31),
  ('Singapura',           32),
  ('Munchkin',            33),
  ('LaPerm',              34),
  ('Nebelung',            35),
  ('Korat',               36),
  ('American Curl',       37),
  ('Havana Brown',        38),
  ('Japanese Bobtail',    39),
  ('Pixiebob',            40),
  ('Burmilla',            41),
  ('Cymric',              42)
) AS b(name, ord)
WHERE s.name = 'Cat';
