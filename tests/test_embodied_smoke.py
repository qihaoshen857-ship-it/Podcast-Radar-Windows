import pytest
from app.embodied_smoke import settle_visible_window


class NativeWindow:
    def __init__(self):
        self.events = []
        self.mapped = False
        self.width = self.height = 1

    def deiconify(self):
        self.events.append("deiconify")

    def geometry(self, value):
        self.requested = tuple(map(int, value.split("x")))

    def update(self):
        self.events.append("native events")
        self.mapped = True
        self.width, self.height = self.requested

    def update_idletasks(self):
        self.events.append("idle")

    def winfo_ismapped(self):
        return self.mapped

    def winfo_width(self):
        return self.width

    def winfo_height(self):
        return self.height


def test_measurement_waits_for_native_mapping_events():
    root = NativeWindow()
    settle_visible_window(root, 1080, 720)
    assert root.events == ["deiconify", "native events", "idle"]
    assert (root.width, root.height) == (1080, 720)


def test_unmapped_window_fails_instead_of_skipping_layout_checks():
    root = NativeWindow()
    root.update = lambda: None
    with pytest.raises(AssertionError, match="Window did not map"):
        settle_visible_window(root, 1080, 720, timeout=0)
