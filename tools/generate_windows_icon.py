from pathlib import Path

from PIL import Image


ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / "assets" / "ResearchPodcastRadar_icon_1024.png"
TARGET = ROOT / "assets" / "PodcastRadar.ico"


def main() -> None:
    image = Image.open(SOURCE).convert("RGBA")
    sizes = [(16, 16), (24, 24), (32, 32), (48, 48), (64, 64), (128, 128), (256, 256)]
    image.save(TARGET, format="ICO", sizes=sizes)
    print(TARGET)


if __name__ == "__main__":
    main()
