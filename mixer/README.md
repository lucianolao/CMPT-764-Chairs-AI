# CMPT 764 - Final Project Mixer

## Code Overview

1. `adjust_chair_parts.m`:
    * Take the chair arms, chair back, chair base (legs), and chair seat as an input, and adjust them according to a heuristic algorithm.
    * The chair seat is considered to be the centerpiece part, while the other parts are scaled and translated to fit the seat.
2. `generate_chair_samples.m`:
    * Generate the positive and the negative chair samples (front, side, and top chair views) used for the scorer model training and validation.
    * The positive chair samples consist of the original PartNet chairs without any modifications.
    * The negative chair samples consist of the randomly mixed PartNet chair parts without any adjustments.
3. `get_random_ids.m`:
    * Given a list of chair IDs, return a randomly ordered set of 4 chair IDs if possible.
    * If the number of the provided chair IDs is less than 4, attempts to minimize the duplicated chair IDs.
4. `load_chair.m`:
    * Given a chair ID, load the chair parts' point cloud files, and return them in a Nx3 matrix format.
5. `mixer.m`:
    * Main driver function for the mix-and-match heuristic algorithm.
6. `partnet_gan.ipynb`:
    * A PartNet GAN training setup script that, given a pair of chair point clouds, attempts to merge them into a single chair.
    * It is not used in the final submission algorithm.
6. `save_chair.m`:
    * Given the chair parts' point cloud data, save it in a text XYZ format, as well as the segmented front, side, and top view images of the assembled chair.
7. `visualize_chairs.m`:
    * Given a list of chair IDs, visualize the segmented chair point clouds.
8. `visualize_pc.m`:
    * Given the chair parts' point cloud data, visualize the segmented chair point clouds.


## Results

The `mixer.m` sample outputs for test sets A, B, C can be found in the `./results/` folder.
The output file names have the following format:

* `{chair_arm_id}_{chair_back_id}_{chair_base_id}_{chair_seat_id}_{view_perspective}.jpg`
