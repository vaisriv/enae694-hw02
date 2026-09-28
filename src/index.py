import math
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
TEXT_DIR = ROOT / "outputs" / "text"


def heading(problem: str) -> None:
    """Print a clearly delimited problem heading."""
    print(f"\n------\n {problem}\n------")


def write_result(name: str, value: str) -> None:
    """Write one value for direct inclusion in the Typst report."""
    TEXT_DIR.mkdir(parents=True, exist_ok=True)
    (TEXT_DIR / f"{name}.txt").write_text(f"{value}\n", encoding="utf-8")


def problem_1() -> None:
    """Calculate slant range at a specified elevation angle."""
    heading("p01")

    earth_radius_km = 6_378.0
    altitude_km = 500.0
    elevation_deg = 10.0
    elevation_rad = math.radians(elevation_deg)

    slant_range_km = (
        math.sqrt(
            (earth_radius_km + altitude_km) ** 2
            - earth_radius_km**2 * math.cos(elevation_rad) ** 2
        )
        - earth_radius_km * math.sin(elevation_rad)
    )
    rounded_range_km = round(slant_range_km)

    print(f"Slant range (unrounded): {slant_range_km:.6f} km")
    print(f"Slant range (nearest km): {rounded_range_km} km")
    write_result("s01", str(rounded_range_km))


def problem_2() -> None:
    """Calculate the Voyager 2 X-band link budget."""
    heading("p02")

    range_km = 21_476_670_660.0
    frequency_ghz = 8.415
    transmit_power_w = 12.3
    transmit_gain_dbi = 48.20
    receive_gain_dbi = 74.01
    transmit_feed_loss_db = 0.0
    other_losses_db = 0.42

    transmit_power_dbw = 10.0 * math.log10(transmit_power_w)
    eirp_dbw = transmit_power_dbw - transmit_feed_loss_db + transmit_gain_dbi
    path_loss_db = (
        92.45
        + 20.0 * math.log10(range_km)
        + 20.0 * math.log10(frequency_ghz)
    )
    received_power_dbw = (
        eirp_dbw - path_loss_db + receive_gain_dbi - other_losses_db
    )

    print(f"Transmit power: {transmit_power_dbw:.6f} dBW")
    print(f"EIRP: {eirp_dbw:.1f} dBW")
    print(f"Free-space path loss: {path_loss_db:.1f} dB")
    print(f"Received power: {received_power_dbw:.1f} dBW")
    write_result("s02a", f"{eirp_dbw:.1f}")
    write_result("s02b", f"{path_loss_db:.1f}")
    write_result("s02c", f"{received_power_dbw:.1f}")


def problem_3() -> None:
    """Problem 3 is qualitative and requires no numerical computation."""
    heading("p03")
    print("No numerical output: see the qualitative explanation in the report.")


def main() -> None:
    problem_1()
    problem_2()
    problem_3()


if __name__ == "__main__":
    main()
