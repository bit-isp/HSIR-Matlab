# HSIR-Matlab

![Visitors](https://api.visitorbadge.io/api/visitors?path=https%3A%2F%2Fgithub.com%2Fbit-isp%2FHSIR-Matlab&countColor=%23263759&style=flat)

🚧 *Under Construction*


Collections of Hyperspectral Image Restoration Algorithms in Matlab


## Usage

1. `cd` into task directory, e.g., `gaussian/BM4D`.
2. Launch `Matlab` .

```matlab
single_eval
batch_eval
```

## Supported Methods

<table>
  <tbody>
    <tr align="center" valign="bottom">
      <td>
        <b>Gaussian Denoising</b>
      </td>
      <td>
        <b>Complex Denoising</b>
      </td>
    </tr>
    <tr valign="top">
      <td>
        <ul>
            <li><a href="">BM4D </a></li>
            <li><a href="">ITSReg </a></li>
            <li><a href="">KBR</a></li>
            <li><a href="">LLRT</a></li>
            <li><a href="">NGmeet</a></li>
            <li><a href="">TDL</a></li>
            <li><a href="">WLRTR</a></li>
      </ul>
      </td>
      <td>
        <ul>
          <li><a href="#">LRMR</a></li>
          <li><a href="#">LRTV</a></li>
          <li><a href="#">NMoG</a></li>
          <li><a href="#">TDTV</a></li>
        </ul>
      </td>
    </tr>
</td>
    </tr>
  </tbody>
</table>

## Acknowledgement

- [QRNN3D](https://github.com/Vandermode/QRNN3D)

## Citation

If you find this repo helpful, please considering citing us.

```bibtex
@article{LAI2022281,
    title = {Deep plug-and-play prior for hyperspectral image restoration},
    journal = {Neurocomputing},
    volume = {481},
    pages = {281-293},
    year = {2022},
    issn = {0925-2312},
    doi = {https://doi.org/10.1016/j.neucom.2022.01.057},
    author = {Zeqiang Lai and Kaixuan Wei and Ying Fu},
}
@article{wei2020QRNN3D,
  title={3-D Quasi-Recurrent Neural Network for Hyperspectral Image Denoising},
  author={Wei, Kaixuan and Fu, Ying and Huang, Hua},
  journal={IEEE Transactions on Neural Networks and Learning Systems},
  year={2020},
  publisher={IEEE}
}

```

