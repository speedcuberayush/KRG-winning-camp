import "./Gallery.scss";
import React from "react";

const GalleryItem = ({ url, photographer, imgSrc, imgAlt }) => (
  <a href={url} target="_blank" className="gallery__link">
    <figure className="gallery__thumb">
      <img src={imgSrc} alt={imgAlt} className="gallery__image" />
      <figcaption className="gallery__caption">
        Portrait by {photographer}
      </figcaption>
    </figure>
  </a>
);

const GalleryColumn = ({ items }) => (
  <div className="gallery__column">
    {items.map((item, index) => (
      <GalleryItem
        key={index}
        url={item.url}
        photographer={item.photographer}
        imgSrc={item.imgSrc}
        imgAlt={item.imgAlt}
      />
    ))}
  </div>
);

const Gallery = () => {
  const galleryItems = [
    {
      url: "https://cdn.leonardo.ai/users/a0e3d238-9331-4629-8e65-7dd741edb548/generations/9292494d-1b21-483d-96c1-0a3af5c81f01/Default_event_management_illustration_blue_technical_theme_3.jpg",
      photographer: "DEVELOPERS HUB",
      imgSrc:
        "https://cdn.leonardo.ai/users/a0e3d238-9331-4629-8e65-7dd741edb548/generations/9292494d-1b21-483d-96c1-0a3af5c81f01/Default_event_management_illustration_blue_technical_theme_3.jpg",
      imgAlt: "Hackethon",
    },
    {
      url: "https://unsplash.com/@oladimeg",
      photographer: "Oladimeji Odunsi",
      imgSrc:
        "https://cdn.leonardo.ai/users/a0e3d238-9331-4629-8e65-7dd741edb548/generations/9292494d-1b21-483d-96c1-0a3af5c81f01/Default_event_management_illustration_blue_technical_theme_1.jpg",
      imgAlt: "Portrait by Oladimeji Odunsi",
    },
    {
      url: "https://unsplash.com/@a2eorigins",
      photographer: "Alex Perez",
      imgSrc:
        "https://cdn.leonardo.ai/users/a0e3d238-9331-4629-8e65-7dd741edb548/generations/2bbed4e5-e8f3-462e-b7f3-480c290022b4/Default_technical_event_management_blue_theme_1.jpg",
      imgAlt: "Portrait by Alex Perez",
    },
    {
      url: "https://unsplash.com/@hikiapp",
      photographer: "Hikiapp",
      imgSrc:
        "https://cdn.leonardo.ai/users/a0e3d238-9331-4629-8e65-7dd741edb548/generations/8036477c-5182-4bef-8559-42cce91d0e2e/Default_generate_me_a_background_for_my_event_management_peopl_3.jpg",
      imgAlt: "Portrait by Hikiapp",
    },
    {
      url: "https://unsplash.com/@von_co",
      photographer: "Ivana Cajina",
      imgSrc:
        "https://cdn.leonardo.ai/users/a0e3d238-9331-4629-8e65-7dd741edb548/generations/018806e9-2bf2-4d5c-ba5c-3eb647b77ab5/Default_all_the_physics_scientists_sitting_in_one_frame_1.jpg?w=512",
      imgAlt: "Portrait by Ivana Cajina",
    },
    {
      url: "https://unsplash.com/@j_erhunse",
      photographer: "Jeffery Erhunse",
      imgSrc:
        "https://cdn.leonardo.ai/users/a0e3d238-9331-4629-8e65-7dd741edb548/generations/2bbed4e5-e8f3-462e-b7f3-480c290022b4/Default_technical_event_management_blue_theme_0.jpg",
      imgAlt: "Portrait by Jeffery Erhunse",
    },
    {
      url: "https://unsplash.com/@ethanhaddox",
      photographer: "Ethan Haddox",
      imgSrc:
        "https://cdn.leonardo.ai/users/a0e3d238-9331-4629-8e65-7dd741edb548/generations/018806e9-2bf2-4d5c-ba5c-3eb647b77ab5/Default_all_the_physics_scientists_sitting_in_one_frame_0.jpg?w=512",
      imgAlt: "Portrait by Ethan Haddox",
    },
    {
      url: "https://unsplash.com/@mr_geshani",
      photographer: "Amir Geshani",
      imgSrc:
        "https://cdn.leonardo.ai/users/a0e3d238-9331-4629-8e65-7dd741edb548/generations/7a7cafd8-1389-4144-8245-2e8e6a267238/Default_generate_me_a_background_for_my_event_management_syste_2.jpg",
      imgAlt: "Portrait by Amir Geshani",
    },
    {
      url: "https://unsplash.com/@nixcreative",
      photographer: "Tyler Nix",
      imgSrc:
        "https://cdn.leonardo.ai/users/a0e3d238-9331-4629-8e65-7dd741edb548/generations/2bbed4e5-e8f3-462e-b7f3-480c290022b4/Default_technical_event_management_blue_theme_0.jpg",
      imgAlt: "Portrait by Tyler Nix",
    },
    {
      url: "https://unsplash.com/@dimadallacqua",
      photographer: "Dima DallAcqua",
      imgSrc:
        "https://cdn.leonardo.ai/users/a0e3d238-9331-4629-8e65-7dd741edb548/generations/2bbed4e5-e8f3-462e-b7f3-480c290022b4/Default_technical_event_management_blue_theme_0.jpg",
      imgAlt: "Portrait by Dima DallAcqua",
    },
  ];

  const columns = 3;
  const itemsPerColumn = Math.ceil(galleryItems.length / columns);
  const galleryColumns = [];

  for (let i = 0; i < columns - 1; i++) {
    galleryColumns.push(
      galleryItems.slice(i * itemsPerColumn, (i + 1) * itemsPerColumn)
    );
  }

  return (
    <div className="gallery">
      {galleryColumns.map((column, index) => (
        <GalleryColumn key={index} items={column} />
      ))}
    </div>
  );
};

export default Gallery;
